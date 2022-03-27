//
//  EventsTableViewController.swift
//  TheScore
//
//  Created by Omar Ahmed on 28/02/2022.
//

import UIKit
import Alamofire
import SDWebImage
import CoreData
import ViewAnimator

class EventsTableViewController: UITableViewController, CellViewDelegate {
    
    @IBOutlet weak var favOutlet: UIBarButtonItem!
    
    var isLoved = false
    
    var titleName:String=""
    
    var latestArray:[Event] = []
    
    var leagueObject : Country?
    
    var leagueCorearr=[League]()
    
    
    func cellIsClicked(for team: Team) {
        let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController")  as! TeamDetailsViewController
        teamDetails.team=team
        self.present(teamDetails, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title=titleName
        tableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "teamsTC")
        tableView.register(UINib(nibName: "UpComingTableViewCell", bundle: nil), forCellReuseIdentifier: "upcomingCell")
        tableView.register(UINib(nibName: "LatestTableViewCell", bundle: nil), forCellReuseIdentifier: "latestCell")
        getLatestEventsData()
        checkState()
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let animation = AnimationType.from(direction: .right, offset: 300)
//        UIView.animate(views: tableView.visibleCells, animations: [animation] ,duration: 2)
//    }
//
    

    @IBAction func addToFavourite(_ sender: Any) {
        isLoved.toggle()
        if isLoved{
            if !checkIfItemExist(strLeague: (leagueObject?.strLeague!)!){
                saveLeagueToCoreData()
            }
        }else{
            if checkIfItemExist(strLeague: (leagueObject?.strLeague!)!){
                removeFromFavs()
            }
        }
        DispatchQueue.main.async {
            self.updateFav()
        }
    }
    
    
    
    
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return latestArray.count
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Events"
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
      let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 25))
        headerView.backgroundColor = .black
        var headerSection : String = ""
        switch section {
        case 0:
            headerSection = "Teams"
        case 1:
            headerSection = "Upcoming Events"
        case 2:
            headerSection = "Latest Events"
        default:
            headerSection="Events"
        }
        headerView.backgroundColor = .black
        let header = UILabel(frame: CGRect(x: 10, y: -8, width: tableView.bounds.size.width, height: 25))
        header.text=headerSection
        header.textColor =  .white
        header.font = .boldSystemFont(ofSize: 22)
        headerView.addSubview(header)
      
      return headerView
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamsTC", for: indexPath) as! TeamsTableViewCell
            cell.delegate = self
            return cell
        case 1:
           let  cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpComingTableViewCell
            return cell
        default:
            let  cell = tableView.dequeueReusableCell(withIdentifier: "latestCell", for: indexPath) as! LatestTableViewCell
            
            cell.matchBadge.sd_setImage(with: URL(string: latestArray[indexPath.row].strThumb!), placeholderImage: UIImage(named: "noItem"))
            cell.matchState.text="Ended"
            if let strname = latestArray[indexPath.row].strHomeTeam{
                cell.teamHomeName.text=strname
            }
            if let strname = latestArray[indexPath.row].strAwayTeam{
                cell.teamAwayName.text=strname
            }
            cell.matchDte.text=latestArray[indexPath.row].dateEvent!
            cell.matchTimee.text=latestArray[indexPath.row].strTime!
            cell.homeGoals.text=latestArray[indexPath.row].intHomeScore
            cell.awayGoals.text=latestArray[indexPath.row].intAwayScore
            cell.matchBadge.layer.cornerRadius=40
            cell.matchView.layer.borderWidth=0.1
            cell.matchView.layer.shadowColor=UIColor.white.cgColor
            cell.matchView.layer.shadowOpacity=0.4
            cell.matchView.layer.cornerRadius=40
            cell.matchView.layer.shadowRadius=2
            cell.matchView.layer.borderColor = UIColor.lightGray.cgColor
            return cell

        }
        
    }
    

}
