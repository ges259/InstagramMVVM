//
//  NotificationViewModel.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/09.
//

import UIKit

struct NotificationViewModel {
    private var notification: Notification
    
    
    var postImageURL: URL? { return URL(string: self.notification.postImageUrl ?? "") }
    
    var profileImageURL: URL? { return URL(string: self.notification.profileImageURL) }
    
    
    var notificationLabel: NSAttributedString {
        return NSMutableAttributedString().attributedText(
            type1TextString: self.notification.userName,
            type1Foreground: UIColor.black,
            type1FontName: .bold,
            type1FontSize: 15,
            
            type2TextString: self.notification.type.notificationMessage,
            type2Foreground: UIColor.black,
            type2FontName: .system,
            type2FontSize: 14,
        
            type3TextString: "   2m",
            type3Foreground: UIColor.lightGray,
            type3FontName: .system,
            type3FontSize: 12)
    }
    
    var returnPostId: String? { return self.notification.postId }
    
    var followBtnText: String {
        return self.notification.userIsFollow
        ? "Following"
        : "Follow"
    }
    
    var followBtnBackgroundColor: UIColor {
        return self.notification.userIsFollow
        ? UIColor.white
        : UIColor.blue
    }
    var followBtnTextColor: UIColor {
        return self.notification.userIsFollow
        ? UIColor.black
        : UIColor.white
    }
    
    

    // Follow_Type -> false
    // other -> true
//    var notificationFollowType: Bool { return !(self.notification.type == .follow)}
    var notificationType: NotificationEnum { return notification.type }
    
    
    var userIsFollow: Bool {
        get {
            return self.notification.userIsFollow
        }
        set {
            self.notification.userIsFollow.toggle()
        }
    }
    
    var notificationUid: String { return self.notification.currentUid}
    
    
    init(notification: Notification) {
        self.notification = notification
    }
}
