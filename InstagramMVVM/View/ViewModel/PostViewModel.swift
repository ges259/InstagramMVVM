//
//  PostViewModel.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import UIKit

struct PostViewModel {
    var post: Post
    
    
    var imageURL: URL? { return URL(string: self.post.postImageUrl) }
    
    
    var caption: String { return self.post.caption }
    
    
    var likes: Int { return self.post.likes }
    
    var likesLabelText: String {
        return post.likes != 1
        ? "\(self.post.likes) likes"
        : "\(self.post.likes) like"
    }
    
    
    var likeBtnTintColor: UIColor {
        return self.post.didLike ? UIColor.red : UIColor.black
    }
    
    var likeBtnImg: UIImage {
        return self.post.didLike ? #imageLiteral(resourceName: "like_selected") : #imageLiteral(resourceName: "like_unselected")
    }
    
    var postTime: String? {
        return Date.dateString(dateDouble: self.post.timeStamp,
                               unitStyle: .full)
    }
    
    
    
    var profileImageURL: URL? { return URL(string: self.post.ownerImageURL) }
    
    var userName: String { return self.post.ownerUserName }
    
    // MARK: - LifeCycle
    init(post: Post) {
        self.post = post
    }

    
    
    
}
