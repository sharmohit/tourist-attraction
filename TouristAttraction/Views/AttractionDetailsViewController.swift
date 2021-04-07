//
//  AttractionDetailsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionDetailsViewController: UIViewController {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    
    var session = Session()
    var attractionIndex = 0
    var attraction = Attraction()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(self.attraction.name) Details")
        phoneLabel.text = attraction.phone
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ratingSlider.value = defaults.float(forKey:"\(self.session.currentUsername)rating\(attractionIndex)")
        ratingLabel.text = "Rated \(Int(ratingSlider.value.rounded(.toNearestOrAwayFromZero)))"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.setValue(ratingSlider.value, forKey:"\(self.session.currentUsername)rating\(attractionIndex)")
    }
    
    @IBAction func ratingWasMoved(_ sender: UISlider) {
        ratingLabel.text = "Rated \(Int(ratingSlider.value.rounded(.toNearestOrAwayFromZero)))"
    }
    
    @IBAction func callWasTapped(_ sender: UIButton) {
        if let url = URL(string: "tel://\(phoneLabel.text!)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func websiteWasTapped(_ sender: UIButton) {
        guard let webView = storyboard?.instantiateViewController(identifier: "web_vc") as? WebViewController else {
                    print("Cannot find the second screen!")
                    return
                }
        
        webView.url = self.attraction.website
        
        webView.view.backgroundColor = .white
        webView.modalPresentationStyle = .fullScreen
        webView.modalTransitionStyle = .crossDissolve
        show(webView, sender:self)
    }
    
    @IBAction func logoutWasTapped(_ sender: UIButton) {
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
}
