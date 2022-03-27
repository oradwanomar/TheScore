//
//  UpComingTableViewCell.swift
//  TheScore
//
//  Created by Omar Ahmed on 01/03/2022.
//

import UIKit
import Alamofire
import SDWebImage

class UpComingTableViewCell: UITableViewCell {

    @IBOutlet weak var upComingCollectionView: UICollectionView!
    
    var eventsArray:[Event]=[]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upComingCollectionView.dataSource=self
        upComingCollectionView.delegate=self
        upComingCollectionView.register(UINib(nibName: "UpComingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "upcomingCVCell")
        getEventsData()
    }
    func getEventsData(){
        guard let idLeague = UserDefaults.standard.object(forKey: "idLeague") else {return}
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(idLeague)&r=31") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            result in
            switch result.result{
            case .failure(_):
                print("Error")
            case .success(_):
                guard let data = result.data else {return}
                
                let json = try! JSONDecoder().decode(UpCommingModel.self, from:data)
                guard let event = json.events else {return}
                self.eventsArray=event
                DispatchQueue.main.async {
                    self.upComingCollectionView.reloadData()
                }
            }
        }
    }
}




extension UpComingTableViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCVCell", for: indexPath) as! UpComingCollectionViewCell
        
        cell.upComingImgV.sd_setImage(with: URL(string: eventsArray[indexPath.row].strThumb!), placeholderImage: UIImage(named: "noItem"))
        cell.matchStatusLabel.text="Not Started"
        cell.homeNameLabel.text=eventsArray[indexPath.row].strHomeTeam!
        cell.awayNameLabel.text=eventsArray[indexPath.row].strAwayTeam!
        cell.dateMatchLabel.text=eventsArray[indexPath.row].dateEvent!
        cell.timeMatchLabel.text=eventsArray[indexPath.row].strTime!
        cell.layer.borderWidth=0.1
        cell.layer.shadowColor=UIColor.white.cgColor
        cell.layer.shadowOpacity=0.4
        cell.layer.cornerRadius=40
        cell.layer.shadowRadius=2
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    
}


extension UpComingTableViewCell:UICollectionViewDelegate{
    
}

extension UpComingTableViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 190)
    }
}
