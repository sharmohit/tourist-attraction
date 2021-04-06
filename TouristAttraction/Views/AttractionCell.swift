//
//  AttractionTableViewCell.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addWishListButton: UIButton!
    
    var delegate:AttractionCellDelegate?
    var indexPath:IndexPath!
    var isWishList:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addWishListWasTapped(_ sender: Any) {
        self.isWishList.toggle()
        updateWishButton(isWishList:self.isWishList)
        self.delegate?.addWishListWasTapped(indexPath:self.indexPath, isWishList:self.isWishList)
    }
    
    func updateWishButton(isWishList:Bool) {
        self.isWishList = isWishList
        if isWishList {
            addWishListButton.setTitle("Remove WishList", for:UIControl.State.normal)
        } else {
            addWishListButton.setTitle("Add WishList", for:UIControl.State.normal)
        }
    }
}

protocol AttractionCellDelegate {
    func addWishListWasTapped(indexPath:IndexPath, isWishList:Bool)
}
