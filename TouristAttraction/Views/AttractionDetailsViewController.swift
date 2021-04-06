//
//  AttractionDetailsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionDetailsViewController: UIViewController {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    
    
    var session = Session()
    var attractionIndex = 0
    var attraction = Attraction()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(self.attraction.name) Details")
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
}
