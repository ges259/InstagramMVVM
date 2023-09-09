//
//  DBString.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import FirebaseDatabase
import Firebase

let DB_REF: DatabaseReference = Database.database().reference()

let USER_REF: DatabaseReference = DB_REF.child("users")
let FOLLOWERS_REF: DatabaseReference = DB_REF.child("following")
let FOLLOWING_REF: DatabaseReference = DB_REF.child("followers")
let POSTS_REF: DatabaseReference = DB_REF.child("posts")
let USER_POSTS_REF: DatabaseReference = DB_REF.child("user-posts")
let NOTIFICATIONS_REF: DatabaseReference = DB_REF.child("notifications")


struct DBString {
    // [User]
    static let uid: String = "uid"
    static let email: String = "email"
    static let fullName: String = "fullName"
    static let userName: String = "userName"
    static let profileImgUrl: String = "profileImgUrl"
    
    static let userInfo: String = "user-info"
    
    // [Post]
    static let caption: String = "caption"
    static let timeStamp: String = "timeStamp"
    static let likes: String = "likes"
    static let postImageUrl: String = "postImageUrl"
    static let postOwnerUid: String = "postOwnerUid"
    static let postId: String = "postId"
    static let ownerImageURL: String = "ownerImageURL"
    static let ownerUserName: String = "ownerUserName"
    
    
    static let postUserName: String = "post-userName"
    static let postFeed: String = "post-feed"
    
    // [Comment]
    static let commet: String = "comment"
    
    // [Like]
    static let postLikesUsers: String = "post-like-users"
    static let userLikesPosts: String = "user-like-posts"
    
    
    // [Notification]
    static let type: String = "type"
    static let notificationId: String = "notificationId"
    static let userNotifiations: String = "user-notifications"
}

