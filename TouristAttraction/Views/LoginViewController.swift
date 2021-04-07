//
//  ViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 02/04/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveLoginSwitch: UISwitch!
    
    let session:Session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if session.initiateLogin() {
            showHomeView(animated:false)
        }
    }
    
    @IBAction func loginWasTapped(_ sender: UIButton) {
        
        if usernameTextField.text == "" {
            showAlert(title:"Error", message:"Username cannot be empty")
        }
        
        if session.isValidUsername(username:usernameTextField.text!) {
            if passwordTextField.text == "" {
                showAlert(title:"Error", message:"Password cannot be empty")
            }
            
            if session.login(username:usernameTextField.text ?? "",
                             password:passwordTextField.text ?? "",
                             isSaveLogin:saveLoginSwitch.isOn) {
                showHomeView(animated:true)

            } else {
                showAlert(title:"Error", message:"Invalid username or password")
            }
        }
        else {
            showAlert(title:"Error", message:"User does not exist")
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showHomeView(animated:Bool) {
        guard let homeView = storyboard?.instantiateViewController(identifier: "home_vc") as? HomeViewController else {
                    print("Cannot find the second screen!")
                    return
                }
        homeView.session = self.session
        homeView.view.backgroundColor = .white
        homeView.modalTransitionStyle = .crossDissolve
        homeView.modalPresentationStyle = .fullScreen
        present(homeView, animated:animated)
    }
}
