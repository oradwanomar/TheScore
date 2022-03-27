//
//  ViewController.swift
//  TheScore
//
//  Created by Omar Ahmed on 22/02/2022.
//

import UIKit

class ViewController: UIViewController {
     
    private let imageview : UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageview.image=UIImage(named: "logo")
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageview)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageview.center=view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageview.frame = CGRect(x: -(CGFloat(Int(diffX)/2)), y: CGFloat(Int(diffY)/2), width: size, height: size)
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageview.alpha=0
        },completion: {done in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                if done {
                    let sportsLeagueViewController = SportsCollectionViewController()
                    sportsLeagueViewController.modalPresentationStyle = .fullScreen
                    self.present(sportsLeagueViewController, animated: true)
                }
            })
            
        })
        
        
    }


}

