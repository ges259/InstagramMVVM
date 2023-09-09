//
//  NotificationService.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/09.
//

import Firebase

struct NotificationService {
    
    // MARK: - Upload_Notificcation
    static func uploadNotification(toUid: String,
                                   currentUser user: User,
                                   type: NotificationEnum,
                                   post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid,
              toUid != currentUid else { return }
        
        let notificationRef = NOTIFICATIONS_REF
            .child(toUid)
            .child(DBString.userNotifiations)
            .childByAutoId()
        
        guard let notificationId = notificationRef.key else { return }
        
        var data: [String: Any] = [DBString.timeStamp: Int(Date().timeIntervalSince1970),
                                   DBString.type: type.rawValue,
                                   DBString.notificationId: notificationId,
                                   
                                   DBString.uid: currentUid,
                                   DBString.profileImgUrl: user.profileImgUrl,
                                   DBString.userName: user.userName]
        //
        if let post = post {
            data[DBString.postId] = post.postId
            data[DBString.postImageUrl] = post.postImageUrl
        }
        notificationRef.updateChildValues(data)
    }
    
    
    
    
    // MARK: - Fetch_Notificcation
    static func fetchNotifications(completion: @escaping ([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        NOTIFICATIONS_REF.child(uid)
            .child(DBString.userNotifiations)
            .observeSingleEvent(of: .value) { snapshot in
                
                guard let value = snapshot.value as? [String: Any] else { return }
                
                var notifications = value.map({ Notification(dictionary: $0.value as! [String: Any]) })
                
                // notication 정렬
                notifications.sort { noti1, noti2 in
                    return noti1.timeStamp > noti2.timeStamp
                }
                
                FOLLOWERS_REF.child(uid)
                    .observeSingleEvent(of: .value) { snapshot in
                        
                        var num = 0
                        notifications.forEach { followingUser in
                            if notifications[num].type == .follow {
                                let didFollow = snapshot.hasChild(followingUser.currentUid)
                                
                                notifications[num].userIsFollow = didFollow
                            }
                            num += 1
                        }
                        completion(notifications)
                    }
            }
    }
}
