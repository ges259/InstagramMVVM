//
//  Notification.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/09.
//

import Foundation

struct Notification {
    let currentUid: String
    
    var postId: String?
    var postImageUrl: String?
    
    let timeStamp: Double
    
    let notificationId: String
    let type: NotificationEnum
    
    let profileImageURL: String
    let userName: String
    
    var userIsFollow: Bool = false
    
    init(dictionary: [String: Any]) {
        self.currentUid = dictionary[DBString.uid] as? String ?? ""
        self.postId = dictionary[DBString.postId] as? String ?? ""
        self.postImageUrl = dictionary[DBString.postImageUrl] as? String ?? ""
        self.timeStamp = dictionary[DBString.timeStamp] as? Double ?? 0
        self.type = NotificationEnum(rawValue: dictionary[DBString.type] as? Int ?? 0) ?? NotificationEnum.like
        self.notificationId = dictionary[DBString.notificationId] as? String ?? ""
        self.profileImageURL = dictionary[DBString.profileImgUrl] as? String ?? ""
        self.userName = dictionary[DBString.userName] as? String ?? ""
        
//        if let timeStamp = dictionary[DBString.timeStamp] as? Double {
//            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
//        } else {
//            self.timeStamp = nil
//        }

    }
    
}
