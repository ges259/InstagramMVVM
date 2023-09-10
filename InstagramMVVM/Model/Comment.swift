//
//  Comment.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import Foundation

struct Comment {
    let uid: String
    let userName: String
    let timeStamp: Double
    let commnetText: String
    let profileImageURL: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary[DBString.uid] as? String ?? ""
        self.userName = dictionary[DBString.userName] as? String ?? ""
        self.timeStamp = dictionary[DBString.timeStamp] as? Double ?? 0
        self.commnetText = dictionary[DBString.commet] as? String ?? ""
        self.profileImageURL = dictionary[DBString.profileImgUrl] as? String ?? ""
        
//        if let timeStamp = dictionary[DBString.timeStamp] as? Double {
//            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
//        } else {
//            self.timeStamp = nil
//        }
    }
}
