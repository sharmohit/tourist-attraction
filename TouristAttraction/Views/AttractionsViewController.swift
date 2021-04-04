//
//  AttractionsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var attractionsTableView: UITableView!
    
    var session = Session()
    var attractions:[Attraction] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        loadAttractions()
        
        attractionsTableView.delegate = self
        attractionsTableView.dataSource = self
        
        attractionsTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = attractionsTableView.dequeueReusableCell(withIdentifier: "attractionCell")
        
        if cell == nil {
            cell = UITableViewCell(
                style:UITableViewCell.CellStyle.subtitle,
                reuseIdentifier:"attractionCell")
        }
        
        cell?.textLabel?.text = attractions[indexPath.row].name
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsView = storyboard?.instantiateViewController(identifier: "details_vc") as? AttractionDetailsViewController else {
                    print("Cannot find the second screen!")
                    return
                }
        detailsView.session = self.session
        detailsView.attraction = attractions[indexPath.row]
        
        detailsView.view.backgroundColor = .white
        detailsView.modalPresentationStyle = .fullScreen
        detailsView.modalTransitionStyle = .crossDissolve
        show(detailsView, sender:self)
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
