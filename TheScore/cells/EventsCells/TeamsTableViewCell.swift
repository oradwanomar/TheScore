//
//  TeamsTableViewCell.swift
//  TheScore
//
//  Created by Omar Ahmed on 28/02/2022.
//

import UIKit
import SDWebImage
import Alamofire

class TeamsTableViewCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    var delegate:CellViewDelegate?
   
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    
    var teamsArray:[Team]=[]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamsCollectionView.dataSource=self
        teamsCollectionView.delegate=self
        
        teamsCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCC")
        getTeamsData()
        
    }
    
    func getTeamsData(){
       guard let leagueName = UserDefaults.standard.object(forKey: "strLeague") else {return}
        print(leagueName)
        let edit = (leagueName as AnyObject).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(edit)") else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            result in
            switch result.result{
            case .failure(_):
                print("Error")
            case .success(_):
                guard let data = result.data else {return}
                
                let json = try! JSONDecoder().decode(Teams.self, from:data)
                guard let team = json.teams else {return}
                self.teamsArray=team
                DispatchQueue.main.async {
                    self.teamsCollectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCC", for: indexPath) as! TeamsCollectionViewCell
        if let img = teamsArray[indexPath.row].strTeamBadge {
            cell.teamImgV.sd_setImage(with: URL(string: img), completed: nil)
        }
        cell.teamName.text=teamsArray[indexPath.row].strTeam!
        cell.layer.borderWidth=0.5
        cell.layer.shadowColor=UIColor.white.cgColor
        cell.layer.shadowOpacity=0.5
        cell.layer.cornerRadius=30
        
        return cell
    }
   
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.cellIsClicked(for: teamsArray[indexPath.row])

    }
    
}

protocol CellViewDelegate {
    func cellIsClicked(for team:Team)
}
