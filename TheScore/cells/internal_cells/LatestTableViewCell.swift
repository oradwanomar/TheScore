//
//  LatestTableViewCell.swift
//  TheScore
//
//  Created by Omar Ahmed on 01/03/2022.
//

import UIKit

class LatestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var matchView: UIView!
    
    @IBOutlet weak var matchBadge: UIImageView!
    
    @IBOutlet weak var matchState: UILabel!
    
    
    @IBOutlet weak var matchDte: UILabel!
    
    
    @IBOutlet weak var homeGoals: UILabel!
    
    
    @IBOutlet weak var awayGoals: UILabel!
    
    
    @IBOutlet weak var matchTimee: UILabel!
    
    
    @IBOutlet weak var teamHomeName: UILabel!
    
    
    @IBOutlet weak var teamAwayName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   
    
}
