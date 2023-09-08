//
//  ProfileHeaderViewModel.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    
    
    
    
    var fullName: String { return self.user.fullName }
    
    var profileImgUrl: URL? {
        
        return URL(string: self.user.profileImgUrl)
        
    }
    
    var followBtnText: String {
        if self.user.isCurrentUser {
            return "Edit Profile"
        } else {
            return self.user.isFollowed ? "Following" : "Follow"
        }
    }
    
    

    
    
    
    // MARK: - Output
    var followBtnTitleColor: UIColor {
        return self.user.isCurrentUser ? UIColor.black : UIColor.white
    }
    
    var followBtnBackgroundColor: UIColor {
        return self.user.isCurrentUser ? UIColor.white : UIColor.systemBlue
    }
    
    
    var numFollowers: NSAttributedString {
        return self.labelAttributedTxt(int: self.user.stats.followers,
                                       string: "followers")
    }
    
    var numFollowing: NSAttributedString {
        return self.labelAttributedTxt(int: self.user.stats.following,
                                       string: "following")
    }
    var numPosts: NSAttributedString {
        return self.labelAttributedTxt(int: self.user.stats.post,
                                       string: "post")
    }

    
    
    
    
    // MARK: - LifeCycle
    init(user: User) {
        self.user = user
    }
    
    
    
    // MARK: - Helper_Functions
    private func labelAttributedTxt(int: Int, string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString().attributedText(
            type1TextString: "\(int)\n",
            type1FontName: .bold,
            type1FontSize: 14,
            type1Foreground: UIColor.black,
            type2TextString: string,
            type2FontSize: 14,
            type2Foreground: UIColor.lightGray)
    }
    
}
