//
//  Post.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import UIKit

struct Post {
    var caption: String
    var likes: Int
    let postImageUrl: String
    let postOwnerUid: String
    let timeStamp: Int
    let postId: String
    
    let ownerImageURL: String
    let ownerUserName: String
    
    var didLike: Bool = false

    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        
        self.caption = dictionary[DBString.caption] as? String ?? ""
        self.timeStamp = dictionary[DBString.timeStamp] as? Int ?? 0
        self.likes = dictionary[DBString.likes] as? Int ?? 0
        self.postImageUrl = dictionary[DBString.postImageUrl] as? String ?? ""
        self.postOwnerUid = dictionary[DBString.postOwnerUid] as? String ?? ""
        
        self.ownerImageURL = dictionary[DBString.ownerImageURL] as? String ?? ""
        self.ownerUserName = dictionary[DBString.ownerUserName] as? String ?? ""
    }
}
