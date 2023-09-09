//
//  Enum.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/09.
//



// InputTextView
enum InputTextViewEnum {
    case commentAccessoryView
    case imageUploadController
}

// Font_Style
enum FontStyleEnum {
    case system
    case bold
}

// Notification
enum NotificationEnum: Int {
    case like
    case follow
    case comment
    
    var notificationMessage: String {
        switch self {
        case .like: return " liked your post"
        case .follow: return " started following you"
        case .comment: return " commented on your post"
        }
    }
}
