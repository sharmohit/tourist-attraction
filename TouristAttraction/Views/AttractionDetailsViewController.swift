//
//  AttractionDetailsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionDetailsViewController: UIViewController {

    var session = Session()
    var attraction = Attraction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(self.attraction.name) Details")
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
