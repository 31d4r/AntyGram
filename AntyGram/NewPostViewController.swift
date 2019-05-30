//
//  NewPostViewController.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 29/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth


class NewPostViewController: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIButton!
    

    @IBAction func handlePostButton(_ sender: Any) {
        
        
    guard let userProfile = UserService.currentUserProfile else { return }
        
    let postRef = Database.database().reference().child("posts").childByAutoId()
     
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "fullName": userProfile.fullName
            ],
            "text": textView.text,
            "timestamp": [".sv":"timestamp"]
            ] as [String: Any]
        
    postRef.setValue(postObject, withCompletionBlock: {error, ref in
        if error == nil{
            self.dismiss(animated: true, completion: nil)
        } else {
            //Something about erros bla bla bla
        }
    })
        
        
    }
    
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        textView.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            super.dismiss(animated: flag, completion: completion)
        })
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

      doneButton.layer.cornerRadius = doneButton.bounds.height/2
      doneButton.clipsToBounds = true
        
      textView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
        
        // Remove the nav shadow underline
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
    

}
