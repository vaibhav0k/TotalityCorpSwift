//
//  SecondTableViewCell.swift
//  TotalityCorpAssignment
//
//  Created by Vaibhav Shah on 23/09/23.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var yellowImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var readMoreReview: UITextView!
    
    @IBOutlet weak var readMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
