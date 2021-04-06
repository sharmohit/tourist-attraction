//
//  WishListViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 06/04/21.
//

import UIKit

class WishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var wishListTableView: UITableView!
    
    var session:Session = Session()
    var attractions:[Attraction] = []
    var wishList:[Attraction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadAttractions()
        
        wishListTableView.delegate = self
        wishListTableView.dataSource = self
        wishListTableView.rowHeight = 240
        wishListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadWishList()
        self.wishListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = wishListTableView.dequeueReusableCell(withIdentifier: "wishListCell") as? WishListCell
        
        if cell == nil {
            cell = WishListCell(
                style:WishListCell.CellStyle.default,
                reuseIdentifier:"wishListCell")
        }
        cell?.attractionNameLabel.text = wishList[indexPath.row].name
        cell?.iconImageView.image = UIImage(named:wishList[indexPath.row].icon)
        
        return cell!
    }
    
    func loadAttractions() {
        if let filepath = Bundle.main.path(forResource:"attractions", ofType:"json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let jsonData = contents.data(using: .utf8)!
                let attractions:[Attraction] = try! JSONDecoder().decode([Attraction].self, from:jsonData)
                
                for attraction in attractions {
                    self.attractions.append(attraction)
                }
            } catch {
                print("Cannot load file")
            }
        } else {
            print("File not found")
        }
    }
    
    func loadWishList() {
        
        self.wishList.removeAll()
        
        for index in 0..<self.attractions.count {
            if UserDefaults.standard.bool(forKey:"\(self.session.currentUsername)wishList\(index)") {
                self.wishList.append(attractions[index])
                print("\(self.attractions[index].name) is in WishList")
            }
        }
        
        if self.wishList.count > 0 {
            emptyLabel.isHidden = true
            wishListTableView.isHidden = false
        } else {
            emptyLabel.isHidden = false
            wishListTableView.isHidden = true
        }
    }
}
