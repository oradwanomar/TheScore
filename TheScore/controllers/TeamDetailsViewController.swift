//
//  TeamDetailsViewController.swift
//  TheScore
//
//  Created by Omar Ahmed on 01/03/2022.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var viewKit: UIView!
    @IBOutlet weak var stadiumImgV: UIImageView!
    
    @IBOutlet weak var teamBadge: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var stadiumName: UILabel!
    
    @IBOutlet weak var teamKit: UIImageView!
    
    @IBOutlet weak var youtubeButton: UIButton!
    
    @IBOutlet weak var instaButton: UIButton!
    
    @IBOutlet weak var faceBookButton: UIButton!
    
    @IBOutlet weak var twitterButton: UIButton!
    
    var team:Team?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewKit.layer.shadowRadius=5
        viewKit.layer.borderWidth=0.5
        viewKit.layer.shadowColor=UIColor.lightGray.cgColor
        viewKit.layer.shadowOpacity=1
        viewKit.layer.cornerRadius=30
        viewKit.layer.shadowOffset = .zero
        
        
        
      
        if let teamStad = team?.strStadiumThumb{
            stadiumImgV.sd_setImage(with: URL(string: teamStad))
        }else{
            stadiumImgV.image=UIImage(systemName: "nosign")
        }
        
        if let teamLogo = team?.strTeamBadge{
            teamBadge.sd_setImage(with: URL(string: teamLogo), completed: nil)
        }
        if let teamname = team?.strTeam{
            teamName.text=teamname
        }
        if let teamShirt = team?.strTeamJersey{
            teamKit.sd_setImage(with: URL(string: teamShirt), completed: nil)
        }
        if let nameStad = team?.strStadium{
            stadiumName.text=nameStad
        }
        
        
    }
    

}
