//
//  User.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import Foundation
import FirebaseAuth

struct User {
    let uid: String
    let email: String
    let fullName: String
    let userName: String
    let profileImgUrl: String
    
    
    var stats: UserStats
    
    var isFollowed = false
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.uid }
    
    // uid: String, 
    init(dictionary: [String: Any]) {
        self.uid = dictionary[DBString.uid] as? String ?? ""
        self.email = dictionary[DBString.email] as? String ?? ""
        self.fullName = dictionary[DBString.fullName] as? String ?? ""
        self.userName = dictionary[DBString.userName] as? String ?? ""
        self.profileImgUrl = dictionary[DBString.profileImgUrl] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0)
    }
}


struct UserStats {
    let followers: Int
    let following: Int
//    let post: Int
}
