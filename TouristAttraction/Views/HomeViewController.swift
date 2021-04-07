//
//  HomeViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class HomeViewController: UITabBarController {

    var session:Session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let attractionNavC = self.viewControllers?[0] as! UINavigationController
        let attractionVC = attractionNavC.topViewController as! AttractionsViewController
        attractionVC.session = self.session
        
        let wishListNavC = self.viewControllers?[1] as! UINavigationController
        let wishListVC = wishListNavC.topViewController as! WishListViewController
        wishListVC.session = self.session
    }
}
