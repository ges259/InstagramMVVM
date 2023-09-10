//
//  AuthService.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit
import Firebase
import FirebaseAuth

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImg: UIImage
}



struct AuthService {
    static func logUserIn(email: String, password: String, completion: @escaping () -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Fail to sign in \(error.localizedDescription)")
                return
            } else {
                completion()
            }
        }
    }
    
    
    
    static func register(withCredentials credentials: AuthCredentials, compeltion: @escaping () -> Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImg) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }

                                            
                guard let uid = result?.user.uid else { return }
                let value: [String: Any] = [DBString.uid: uid,
                                            DBString.email: credentials.email,
                                            DBString.fullName: credentials.fullName,
                                            DBString.userName: credentials.userName,
                                            DBString.profileImgUrl: imageUrl]
                
                USER_REF.child(DBString.userInfo).child(uid).setValue(value) { error, ref in
                    if let error = error {
                        print("DEBUG: Failed to register user \(error.localizedDescription)")
                        return
                        
                    } else{ compeltion() }
                }
            }
        }
    }
    
    static func resetPassword(withEmail email: String,
                              completion: @escaping ((Bool)) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("DEBUG: \(#function) - resetPassword Error \(error.localizedDescription)")
                completion(true)
            } else { completion(false) }
            
        }
    }
}
