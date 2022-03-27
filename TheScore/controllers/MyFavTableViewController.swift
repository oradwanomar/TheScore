//
//  MyFavTableViewController.swift
//  TheScore
//
//  Created by Omar Ahmed on 02/03/2022.
//

import UIKit
import CoreData

class MyFavTableViewController: UITableViewController {
    
    @IBOutlet weak var noLeagues: UIImageView!
    
    var leagueCoreArra=[League]()
    
    override func viewWillAppear(_ animated: Bool) {
        getOfflineDataByCoreData()
        
        if leagueCoreArra.count == 0 {
            tableView.isHidden = false
        }else{
            noLeagues.isHidden=true
        }
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func getOfflineDataByCoreData(){
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let manageContext=appDelegate.persistentContainer.viewContext
        do {
            self.leagueCoreArra=try manageContext.fetch(League.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch  {
            print(error)
        }
        
       
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueCoreArra.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! MyFavTableViewCell
        cell.favLeagueName.text=leagueCoreArra[indexPath.row].strLeague
        cell.favLeagueImgV.sd_setImage(with: URL(string: leagueCoreArra[indexPath.row].strBadge!), completed: nil)
        cell.favLeagueYoutube.addAction(UIAction(handler: {_ in if let youtubeStr = self.leagueCoreArra[indexPath.row].strYoutube{
            UIApplication.shared.open(URL(string: "https://\(youtubeStr)")!, options: [:], completionHandler: nil)
        }}), for: .touchUpInside)
        cell.favView.layer.cornerRadius=22
        cell.favView.layer.borderColor=UIColor.lightGray.cgColor
        cell.favView.layer.borderWidth=0.3
        cell.favView.layer.shadowColor=UIColor.white.cgColor
        cell.favView.layer.shadowOpacity=0.6

        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            let alert = UIAlertController(title: "Are you sure?", message: "You will remove this league from your favourite list", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
                context.delete(self.leagueCoreArra[indexPath.row])
                self.leagueCoreArra.remove(at: indexPath.row)
                try? context.save()
                tableView.deleteRows(at: [indexPath], with: .left)
                if leagueCoreArra.count == 0 {
                    noLeagues.isHidden=false
                }
                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
            
        } else if editingStyle == .insert {
        }
    }
    


    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let EventsTVCFav=self.storyboard?.instantiateViewController(withIdentifier: "EventsTableViewController") as! EventsTableViewController
        UserDefaults.standard.set(leagueCoreArra[ indexPath.row].idLeague, forKey: "idLeague")
        UserDefaults.standard.set(leagueCoreArra[indexPath.row ].strLeague, forKey: "strLeague")
        EventsTVCFav.titleName=leagueCoreArra[indexPath.row].strLeague!
//        EventsTVCFav.leagueObject=leagueCoreArra[indexPath.row]
        self.present(EventsTVCFav, animated: true, completion: nil)
    }


}
