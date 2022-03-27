//
//  UpComingCollectionViewCell.swift
//  TheScore
//
//  Created by Omar Ahmed on 01/03/2022.
//

import UIKit

class UpComingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var upComingImgV: UIImageView!
    
    @IBOutlet weak var matchStatusLabel: UILabel!
    
    @IBOutlet weak var dateMatchLabel: UILabel!
    
    @IBOutlet weak var timeMatchLabel: UILabel!
    
    @IBOutlet weak var homeNameLabel: UILabel!
    
    @IBOutlet weak var awayNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
