//
//  WishListCell.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 06/04/21.
//

import UIKit

class WishListCell: UITableViewCell {

    @IBOutlet weak var attractionNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
