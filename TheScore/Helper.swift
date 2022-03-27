//
//  Helper.swift
//  TheScore
//
//  Created by Omar Ahmed on 02/03/2022.
//

import Foundation
import UIKit
import Alamofire
import CoreData
  
extension SportsCollectionViewController {
    
    func displayError( title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        let alert = UIAlertController(title: title, message:"There is no connection right now \n Please check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default,
           handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension EventsTableViewController{
    
    func getLatestEventsData(){
        guard let idLeague = UserDefaults.standard.object(forKey: "idLeague") else {return}
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(idLeague)&r=22") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            result in
            switch result.result{
            case .failure(_):
                print("Error")
            case .success(_):
                guard let data = result.data else {return}
                
                let json = try! JSONDecoder().decode(UpCommingModel.self, from:data)
                guard let event = json.events else {return}
                self.latestArray=event
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func updateFav(){
        if isLoved==true{
            favOutlet.image=UIImage(systemName: "heart.fill")
            self.showToast(message: "Added to Favourites", font: .boldSystemFont(ofSize: 15))
        }else{
            favOutlet.image=UIImage(systemName: "heart")
            self.showToast(message: "Removed From Favourites", font: .boldSystemFont(ofSize: 15))
        }
    }
    
    
    
    func checkIfItemExist(strLeague: String) -> Bool {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
            fetchRequest.fetchLimit =  1
            fetchRequest.predicate = NSPredicate(format: "strLeague == %@" ,strLeague)

            do {
                let count = try managedContext.count(for: fetchRequest)
                if count > 0 {
                    return true
                }else {
                    return false
                }
            }catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return false
            }
        }
    
    
    func saveLeagueToCoreData(){
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
                let league = League(context: context)
                league.idLeague=leagueObject!.idLeague
                league.strLeague=leagueObject!.strLeague
                league.strBadge=leagueObject!.strBadge
                league.strYoutube=leagueObject!.strYoutube
                try? context.save()
        
        print(league)
    }
    
    func removeFromFavs(){
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        do {
            self.leagueCorearr=try context.fetch(League.fetchRequest())
            for i in 0..<leagueCorearr.count {
                if leagueObject?.idLeague == leagueCorearr[i].idLeague{
                    context.delete(leagueCorearr[i])
                    try? context.save()
                }
            }
           
        }catch{
            print(error)
        }
    }
    
    func checkState(){
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        do{
            self.leagueCorearr = try context.fetch(League.fetchRequest())
            for i in 0..<leagueCorearr.count {
                if leagueObject?.idLeague ==  leagueCorearr[i].idLeague {
                    favOutlet.image=UIImage(systemName: "heart.fill")

                }else{
                    favOutlet.image=UIImage(systemName: "heart")
                }
            }
        }catch{
           print(error)
        }
    }
    
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-200, width: 200, height: 40))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


extension SportsCollectionViewController {
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-200, width: 200, height: 40))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
