//
//  CommentService.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import Firebase

struct CommentService {
    
    static func uploadComment(comment: String, postId: String, user: User,
                              completion: @escaping () -> Void) {
        
        let value: [String: Any] = [DBString.commet: comment,
                                    DBString.uid: user.uid,
                                    DBString.timeStamp: Int(NSDate().timeIntervalSince1970),
                                    DBString.userName: user.userName,
                                    DBString.profileImgUrl: user.profileImgUrl]
        
        let commentId = POSTS_REF.child(postId).child(DBString.commet).childByAutoId()
        
        commentId.setValue(value) { error, ref in
            if let error = error {
                print("DEBUG: CommnetService --- uploadCommenet --- \(error.localizedDescription)")
                return
            } else { completion() }
        }
    }
    
    
    
    
    static func fetchComment(forPost postId: String, completion: @escaping ([Comment]) -> Void) {
        
        POSTS_REF.child(postId).child(DBString.commet).observe(.value) { snapshot in
            
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let comment = allObjects.map({ Comment(dictionary: $0.value as! [String : Any])})
            completion(comment.reversed())
        }
    }
}
