//
//  LeaguesTableViewController.swift
//  TheScore
//
//  Created by Omar Ahmed on 23/02/2022.
//

import UIKit
import Alamofire
import SDWebImage
import SkeletonView
import ViewAnimator


class LeaguesTableViewController: UITableViewController{
    
    var leaguesArray:[Country] = []
    var sportName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLeaguesData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let animation = AnimationType.from(direction: .top, offset: 300)
//        UIView.animate(views: tableView.visibleCells, animations: [animation] ,duration: 2)
//    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "legCell", for: indexPath) as! LeaguesTableViewCell
        
        
        cell.leagueName.text=leaguesArray[leaguesArray.count - indexPath.row  - 1].strLeague
        cell.leagueImageView.sd_setImage(with: URL(string: leaguesArray[leaguesArray.count - indexPath.row  - 1].strBadge!))
        cell.leagueYoutubeLink.addAction(UIAction(handler: {_ in if let youtubeStr = self.leaguesArray[self.leaguesArray.count - indexPath.row  - 1].strYoutube{
            UIApplication.shared.open(URL(string: "https://\(youtubeStr)")!, options: [:], completionHandler: nil)
        }}), for: .touchUpInside)
        
        cell.leagueView.layer.cornerRadius=22
        cell.leagueView.layer.borderColor=UIColor.lightGray.cgColor
        cell.leagueView.layer.borderWidth=0.3
        cell.leagueView.layer.shadowColor=UIColor.white.cgColor
        cell.leagueView.layer.shadowOpacity=0.6
        
        return cell
    }
    
    
    func getLeaguesData(){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=\(sportName)") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            result in
            switch result.result{
            case .failure(_):
                print("Error")
            case .success(_):
                guard let data = result.data else {return}
                
                let json = try! JSONDecoder().decode(LeagueModel.self, from:data)
                guard let league = json.countrys else {return}
                self.leaguesArray=league
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let EventsTVC=self.storyboard?.instantiateViewController(withIdentifier: "EventsTableViewController") as! EventsTableViewController
        UserDefaults.standard.set(leaguesArray[leaguesArray.count - indexPath.row - 1].idLeague, forKey: "idLeague")
        UserDefaults.standard.set(leaguesArray[leaguesArray.count - indexPath.row - 1].strLeague, forKey: "strLeague")
        EventsTVC.titleName=leaguesArray[leaguesArray.count - indexPath.row - 1].strLeague!
        EventsTVC.leagueObject=leaguesArray[leaguesArray.count - indexPath.row - 1]
        self.navigationController?.pushViewController(EventsTVC, animated: true)
    }


}
