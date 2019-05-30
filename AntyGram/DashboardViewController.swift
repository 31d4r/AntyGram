//
//  DashboardViewController.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 27/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    @IBOutlet weak var signOutBtn: UIBarButtonItem!
    var posts = [Post]() //Posts array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        //tableView.backgroundColor = UIColor.lightGray
        tableView.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(tableView)
        
        //Manually added tableView
        var layoutGuide: UILayoutGuide!
        layoutGuide = view.safeAreaLayoutGuide
        
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        observePosts()
    }
    
    //Function for showing posts
    func observePosts() {
        let postsRef = Database.database().reference().child("posts")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Post]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let fullName = author["fullName"] as? String,
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
            
                    let userProfile = UserProfile(uid: uid, fullName: fullName)
                    let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                    tempPosts.append(post)
                }
            }
            
            self.posts = tempPosts
            self.tableView.reloadData()
            
        })
    }
    //end function
    
    
    //SignOutBtn func
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutErr {
            print(signOutErr)
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(withIdentifier: "signInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    //end of func
 
    //Settings for tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }

}
