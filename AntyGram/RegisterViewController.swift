//
//  RegisterViewController.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 26/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class RegisterViewController: UIViewController {
    
    
   
    

    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var passwordConf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FullNameImage
        let fullNameImage = UIImage(named:"full-name")
        addLeftImageTo(txtField: fullNameField, andImage: fullNameImage!)
       //Emailimage
        let emailImage = UIImage(named:"email")
        addLeftImageTo(txtField: emailField, andImage: emailImage!)
       //PasswordImage
        let passwordImage = UIImage(named:"password")
        addLeftImageTo(txtField: passwordField, andImage: passwordImage!)
        let passwordConfi = UIImage(named: "password")
        addLeftImageTo(txtField: passwordConf, andImage: passwordImage!)
        
        
        //Deisngs for txtFields
        //FullName
        fullNameField.layer.masksToBounds = true
        fullNameField.layer.cornerRadius = 25
        fullNameField.layer.borderWidth = 0.3
        //Email
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 25
        emailField.layer.borderWidth = 0.3
        //Password
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = 25
        passwordField.layer.borderWidth = 0.3
        //PasswordAgain
        passwordConf.layer.masksToBounds = true
        passwordConf.layer.cornerRadius = 25
        passwordConf.layer.borderWidth = 0.3
        //sgnBtn
        signUpBtn.layer.masksToBounds = true
        signUpBtn.layer.cornerRadius = 25
        
        
    }
    
    //Function for adding an image to txtField
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width/2, height: img.size.height/2))
        
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }//end of function

    //SignUp func
    @IBAction func signUpBtnPressed(_ sender: Any) {
    
        guard let fullName = fullNameField.text else { return }
        
        if passwordField.text != passwordConf.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!){ (user, error) in
                if error == nil {
                    self.saveProfile(fullName: fullName) { success in
                        if success {
                            //self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "signupToHome", sender: self)
                        }
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }//end of signUpBtnPressed
    
    
    //Facebook custom login button -> not working
    @IBAction func fbBtnPressed(_ sender: Any) {
        
        let FBLoginManager = LoginManager()
        FBLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

            Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
    }//end of fb func
    
    
    
    
    
    //Function for saving profile to Firebase
    func saveProfile(fullName:String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "fullName": fullName
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }//end of function
    
    
    
}
