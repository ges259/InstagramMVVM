//
//  PostService.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import UIKit
import Firebase

struct PostService {
    
    // MARK: - Upload_Post
    static func uploadPost(caption: String, image: UIImage, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        ImageUploader.uploadImage(image: image) { imgUrl in
            
            let data: [String: Any] = [DBString.caption: caption,
                                       DBString.timeStamp: creationDate,
                                       DBString.likes: 0,
                                       DBString.postImageUrl: imgUrl,
                                       DBString.postOwnerUid: uid]
            
            let postId = POSTS_REF.childByAutoId()
            
            postId.child(uid).updateChildValues(data) { error, ref in
                if let error = error {
                    print(error.localizedDescription)
                    return
                    
                } else {
                    completion()
                }
            }
        }
    }
    
    
}
