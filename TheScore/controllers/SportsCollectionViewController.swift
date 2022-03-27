//
//  SportsCollectionViewController.swift
//  TheScore
//
//  Created by Omar Ahmed on 22/02/2022.
//

import UIKit
import Alamofire
import SDWebImage
import Reachability
import ViewAnimator

class SportsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let reachability = try! Reachability()

    
    var sportsArray:[Sports]=[]
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
           do{
             try reachability.startNotifier()
           }catch{
             print("could not start reachability notifier")
           }
        
        
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
          showToast(message: "You are Online", font: .systemFont(ofSize: 15))
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
          showToast(message: "You Are Offline now", font: .systemFont(ofSize: 15))
        displayError(title: "Network Error!!")
      case .none:
          print("none")
      }
    }
    

    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
         getSportsData()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let animation = AnimationType.from(direction: .bottom, offset: 300)
        UIView.animate(views: collectionView.visibleCells, animations: [animation] ,duration: 2)
        
    }
    
    
    
    func getSportsData()  {
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {return}
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
            do
            {
                let json =  try! JSONDecoder().decode(Sport.self, from: data!)
                self.sportsArray=json.sports!
                
                DispatchQueue.main.async {
                    self.viewDidAppear(true)
                    self.collectionView.reloadData()
                }
            }
               
        }
        task.resume()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.1, height: view.frame.width/2)
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sportsArray.count
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCell", for: indexPath) as! SportsCollectionViewCell
        
        
        cell.imageSportLabel.sd_setImage(with: URL(string: sportsArray[indexPath.row].strSportThumb!))
        cell.nameSportLabel.text=sportsArray[indexPath.row].strSport
        
        
        cell.layer.borderWidth=0.5
        cell.layer.shadowColor=UIColor.white.cgColor
        cell.layer.shadowOpacity=0.7
        cell.layer.shadowRadius=2
        cell.layer.cornerRadius=25
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueTV=self.storyboard?.instantiateViewController(withIdentifier: "LeaguesTableViewController") as! LeaguesTableViewController
        guard let sportname = sportsArray[indexPath.row].strSport else{return}
        leagueTV.sportName=sportname
        self.navigationController?.pushViewController(leagueTV, animated: true)
    }

}
