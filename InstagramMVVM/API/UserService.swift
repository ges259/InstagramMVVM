//
//  UserService.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import Firebase


struct UserService {
    
    // MARK: - Fetch_User
    static func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        USER_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary: [String: Any] = snapshot.value as? [String : Any] else { return }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        USER_REF.observeSingleEvent(of: .value) { snapshot in
            
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let users = allObjects.map({ User(dictionary: $0.value as! [String : Any])})
            
            completion(users)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Follow / UnFollow
    static func follow(uid: String, completion: @escaping () -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        FOLLOWERS_REF.child(currentUid).updateChildValues([uid: 1]) { error, ref in

            FOLLOWING_REF.child(uid).updateChildValues([currentUid: 1]) { error, ref in
                
                completion()
            }
        }
    }
    
    
    static func unFollow(uid: String, completion: @escaping () -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        
        FOLLOWERS_REF.child(currentUid).child(uid).removeValue { error, ref in
            FOLLOWING_REF.child(uid).child(currentUid).removeValue { error, ref in
                completion()
            }
        }
    }
    
    
    // MARK: - Check_Followed
    static func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        FOLLOWERS_REF.child(currentUid).observeSingleEvent(of: .value) { snapshot in 
            completion(snapshot.hasChild(uid))
        }
    }
    
    
    
    
    
    
    // MARK: - Fetch_Stats
    static func fetchUserStats(uid: String, completion: @escaping (UserStats) -> Void) {
        
        FOLLOWERS_REF.child(uid).observe(.value) { snapshot in
            let followers = Int(snapshot.childrenCount)
            
            FOLLOWING_REF.child(uid).observe(.value) { snapshot in
                let following = Int(snapshot.childrenCount)
                
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
}
