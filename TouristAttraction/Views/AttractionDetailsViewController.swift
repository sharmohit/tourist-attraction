//
//  AttractionDetailsViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 04/04/21.
//

import UIKit

class AttractionDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var photo1ImageView: UIImageView!
    @IBOutlet weak var photo2ImageView: UIImageView!
    @IBOutlet weak var photo3ImageView: UIImageView!
    @IBOutlet weak var photo4ImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    var session = Session()
    var attractionIndex = 0
    var attraction = Attraction()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailsScrollView.contentSize = CGSize(width:self.scrollContentView.frame.size.width, height:self.scrollContentView.frame.size.height)
        
        self.phoneLabel.text = attraction.phone
        self.iconImageView.image = UIImage(named:attraction.icon)
        self.photo1ImageView.image = UIImage(named:attraction.photos[0])
        self.photo2ImageView.image = UIImage(named:attraction.photos[1])
        self.photo3ImageView.image = UIImage(named:attraction.photos[2])
        self.photo4ImageView.image = UIImage(named:attraction.photos[3])
        self.nameLabel.text = " \(attraction.name)"
        self.addressLabel.text = " \(attraction.address)"
        self.priceLabel.text = attraction.price
        self.descriptionLabel.text = attraction.description
        self.websiteLabel.text = attraction.website
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.ratingSlider.value = defaults.float(forKey:"\(self.session.currentUsername)rating\(attractionIndex)")
        self.ratingLabel.text = "\(Int(ratingSlider.value.rounded(.toNearestOrAwayFromZero)))"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.setValue(ratingSlider.value, forKey:"\(self.session.currentUsername)rating\(attractionIndex)")
    }
    
    @IBAction func ratingWasMoved(_ sender: UISlider) {
        self.ratingLabel.text = "\(Int(ratingSlider.value.rounded(.toNearestOrAwayFromZero)))"
    }
    
    @IBAction func callWasTapped(_ sender: UIButton) {
        if let url = URL(string: "tel://\(phoneLabel.text!)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        #if targetEnvironment(simulator)
        showAlert(title:"Unsupported", message:"Call feature is not available on simulator")
        #endif
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
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
