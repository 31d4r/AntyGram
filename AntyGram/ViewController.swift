//
//  ViewController.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 24/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UserNameFieldDesign
        usernameField.layer.masksToBounds = true
        usernameField.layer.cornerRadius = 25
        usernameField.layer.borderWidth = 0.3
       //PasswordFieldDesign
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = 25
        passwordField.layer.borderWidth = 0.3
        //SgnBtn
        signInBtn.layer.masksToBounds = true
        signInBtn.layer.cornerRadius = 25
    }

 
    @IBAction func signInBtnPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

