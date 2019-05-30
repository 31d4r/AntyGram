//
//  UserService.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 29/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import Foundation
import Firebase

class UserService{
    
    static var currentUserProfile:UserProfile?
    //database profiles
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:UserProfile?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let fullName = dict["fullName"] as? String{
  
                userProfile = UserProfile(uid: snapshot.key, fullName: fullName)
            }
            
            completion(userProfile)
        })
    }
}
