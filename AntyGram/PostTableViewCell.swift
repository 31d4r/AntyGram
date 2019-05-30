//
//  PostTableViewCell.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 28/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

  
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Set circle profileImage
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post:Post){
        usernameLabel.text = post.author.fullName
        postTextLabel.text = post.text
        subtitleLabel.text = post.createdAt.calenderTimeSinceNow()
    }
    
}
