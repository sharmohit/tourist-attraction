//
//  AttractionsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AttractionCellDelegate {

    @IBOutlet weak var attractionsTableView: UITableView!
    
    var session = Session()
    var attractions:[Attraction] = []
    var defaults = UserDefaults.standard
        
    override func viewDidLoad() {
        super.viewDidLoad()

        loadAttractions()
        
        attractionsTableView.delegate = self
        attractionsTableView.dataSource = self
        attractionsTableView.rowHeight = 240
        attractionsTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = attractionsTableView.dequeueReusableCell(withIdentifier: "attractionCell") as? AttractionCell
        
        if cell == nil {
            cell = AttractionCell(
                style:AttractionCell.CellStyle.default,
                reuseIdentifier:"attractionCell")
        }
        
        cell?.delegate = self
        cell?.indexPath = indexPath
        let attraction = attractions[indexPath.row]
        cell?.nameLabel.text = " \(attraction.name)"
        cell?.iconImageView.image = UIImage(named:attraction.icon)
        cell?.addressLabel.text = " \(attraction.address)"
        cell?.updateWishButton(isWishList:defaults.bool(forKey:"\(self.session.currentUsername)wishList\(indexPath.row)"))
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsView = storyboard?.instantiateViewController(identifier: "details_vc") as? AttractionDetailsViewController else {
                    print("Cannot find the second screen!")
                    return
                }
        detailsView.session = self.session
        detailsView.attractionIndex = indexPath.row
        detailsView.attraction = attractions[indexPath.row]
        
        detailsView.view.backgroundColor = .white
        detailsView.modalPresentationStyle = .fullScreen
        detailsView.modalTransitionStyle = .crossDissolve
        show(detailsView, sender:self)
    }
    
    func addWishListWasTapped(indexPath:IndexPath, isWishList:Bool) {
        defaults.setValue(isWishList, forKey:"\(self.session.currentUsername)wishList\(indexPath.row)")
    }
    
    @IBAction func logoutWasTapped(_ sender: Any) {
        self.session.logout()
        guard let loginView = storyboard?.instantiateViewController(identifier: "login_vc") as? LoginViewController else {
                    print("Cannot find the second screen!")
                    return
                }
        loginView.view.backgroundColor = .white
        loginView.modalPresentationStyle = .fullScreen
        loginView.modalTransitionStyle = .crossDissolve
        present(loginView, animated:true)
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
}
