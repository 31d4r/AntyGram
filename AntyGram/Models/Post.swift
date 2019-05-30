//
//  Post.swift
//  AntyGram
//
//  Created by Eldar Tutnjic on 28/05/2019.
//  Copyright © 2019 eldartutnjic. All rights reserved.
//

import Foundation


class Post {
    var id:String
    var author:UserProfile
    var text:String
    var createdAt: Date
    
    
    init(id:String, author:UserProfile, text:String, timestamp:Double ) {
        self.id = id
        self.author = author
        self.text = text
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
    }
}

