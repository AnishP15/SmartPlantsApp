//
//  LogInViewController.swift
//  SmartPlantsApp
//
//  Created by Anish Palvai on 4/27/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseAuth
import IQKeyboardManagerSwift
import SVProgressHUD

class LogInViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddress.delegate = self
        password.delegate = self
    }
    
    @IBAction func signIn(_ sender: Any) {
        // SVProgressHUD.show()
        if (emailAddress?.text == "" || password.text == "") {
            showAlert(title: "Oops!", message: "One of the text fields were left incomplete! Please enter in an email or password to access your account.")
            // SVProgressHUD.dismiss()
        }else {
            // SVProgressHUD.show()
            Auth.auth().signIn(withEmail: emailAddress.text!, password: password.text!) { [weak self] user, error in
                if (error != nil) {
                    // self?.showAlert(title: "Oops!", message: "Your information was incorrect. Please try again.")
                    // SVProgressHUD.dismiss()
                    self?.performSegue(withIdentifier: "signInAccount", sender: Any?.self)
                }else {
                    self?.performSegue(withIdentifier: "signInAccount", sender: Any?.self)
                    // SVProgressHUD.show()
                    // self?.performSegueFunction(storyboardName: "Main")
                    // SVProgressHUD.dismiss()
                }
            }
            
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
}
