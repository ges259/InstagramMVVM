//
//  PostService.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import UIKit
import Firebase
import FirebaseStorage

struct PostService {
    
    // MARK: - Upload_Post
    static func uploadPost(user: User, caption: String, image: UIImage, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imgUrl in
            let data: [String: Any] = [DBString.caption: caption,
                                       DBString.timeStamp: Int(NSDate().timeIntervalSince1970),
                                       DBString.likes: 0,
                                       DBString.postImageUrl: imgUrl,
                                       DBString.postOwnerUid: uid,
                                       DBString.ownerImageURL: user.profileImgUrl,
                                       DBString.ownerUserName: user.userName]
            
            let postId = POSTS_REF.child(DBString.postFeed).childByAutoId()
            
            guard let postKey = postId.key else { return }
            
            POSTS_REF
                .child(DBString.postUserName)
                .child(uid)
                .updateChildValues([postKey: 1]) { error, ref in
                    
                    if let error = error {
                        print("DEBUG: UploadPost --- USER_POSTS_REF --- \(error.localizedDescription)")
                        return
                    }
                    
                    postId.updateChildValues(data) { error, ref in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        } else { completion() }
                    }
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Fetch_Feed_Post
    static func fetchFeedPost(completion: @escaping ([Post]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        FOLLOWING_REF
            .child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                
                var userIds = allObjects.map({ $0.key})
                userIds.append(uid)
                var postArray: [Post] = []
                
                userIds.forEach { userId in
                    PostService.fetchPostsWithUid(uid: userId) { posts in
                        postArray.append(contentsOf: posts)
                        
                        PostService.checkPostsLiked(posts: postArray) { newPosts in completion(newPosts) }
                    }
                }
            }
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Fetch_Posts_With_Uid
    static func fetchPostsWithUid(uid: String, completion: @escaping ([Post]) -> Void) {
        POSTS_REF
            .child(DBString.postUserName)
            .child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                
                let postId = allObjects.map({$0.key})
                
                var postArray: [Post] = []
                
                let _: [()] = postId.map({ PostService.fetchPost(postId: $0) { post in
                    postArray.append(post)
                    
                    if postArray.count == postId.count {
                        completion(postArray)
                    }
                }})
            }
    }
    
    
    
    
    // MARK: - Fetch_Post
    static func fetchPost(postId: String, completion: @escaping (Post) -> Void) {
        POSTS_REF
            .child(DBString.postFeed)
            .child(postId)
            .observeSingleEvent(of: .value) { snapshot in
                
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                
                completion(Post(postId: snapshot.key, dictionary: dictionary))
            }
    }
    
    
    
    
    // MARK: - Check_Posts_Liked
    static func checkPostsLiked(posts: [Post], completion: @escaping ([Post]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var posts = posts
        
        USER_REF
            .child(DBString.userLikesPosts)
            .child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                
                posts.forEach { postNum in
                    let didLike = snapshot.hasChild(postNum.postId)
                    
                    if let index = posts.firstIndex(where: { $0.postId == postNum.postId } ) {
                        posts[index].didLike = didLike
                    }
                }
                
                posts.sort { post1, post2 in
                    return post1.timeStamp > post2.timeStamp
                }
                completion(posts)
            }
    }
    
    static func checkPostLikes(postId: String,
                               completion: @escaping (Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        USER_REF
            .child(DBString.userLikesPosts)
            .child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                
                snapshot.hasChild(postId)
                ? completion(true)
                : completion(false)
            }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Like
    static func likePost(post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        POSTS_REF
            .child(DBString.postFeed)
            .child(post.postId)
            .updateChildValues([DBString.likes: post.likes + 1])
        
        POSTS_REF
            .child(DBString.postFeed)
            .child(post.postId)
            .child(DBString.postLikesUsers)
            .updateChildValues([uid: 1]) { error, ref in
                
                if let error = error {
                    print("DEBUG: PostService - likePost() - POST_REF - \(error.localizedDescription)")
                    return
                }
                
                USER_REF
                    .child(DBString.userLikesPosts)
                    .child(uid)
                    .updateChildValues([post.postId: 1]) { error, ref in
                        
                        if let error = error {
                            print("DEBUG: PostService - likePost() - USER_REF  - \(error.localizedDescription)")
                            return
                        } else { completion() }
                    }
            }
    }
    
    
    
    static func unLikePost(post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        POSTS_REF
            .child(DBString.postFeed)
            .child(post.postId)
            .updateChildValues([DBString.likes: post.likes - 1])
        
        POSTS_REF
            .child(DBString.postFeed)
            .child(post.postId)
            .child(DBString.postLikesUsers)
            .child(uid)
            .removeValue { error, ref in
                
                if let error = error {
                    print("DEBUG: PostService - unLikePost() - POST_REF - \(error.localizedDescription)")
                    return
                }
                
                USER_REF
                    .child(DBString.userLikesPosts)
                    .child(uid)
                    .child(post.postId)
                    .removeValue { error, ref in
                        
                        if let error = error {
                            print("DEBUG: PostService - unLikePost() - USER_REF - \(error.localizedDescription)")
                            return
                            
                        } else { completion() }
                    }
            }
    }
}
