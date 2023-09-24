//
//  HomeTableViewCell.swift
//  TotalityCorpAssignment
//
//  Created by Vaibhav Shah on 22/09/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
  
    @IBOutlet var yellowImage: UIImageView!
    
    @IBOutlet var cardView: UIView!
    
    @IBOutlet var buttonPlay: UIButton!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 20
        yellowImage.layer.cornerRadius  = 15
        buttonPlay.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
