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
                let value: [String: Any] = ["uid": uid,
                                            "email": credentials.email,
                                            "fullName": credentials.fullName,
                                            "userName": credentials.userName,
                                            "profileImgUrl": imageUrl]
                
                USER_REF.child(uid).setValue(value) { error, ref in
                    if let error = error {
                        print("DEBUG: Failed to register user \(error.localizedDescription)")
                        return
                    } else{
                        compeltion()
                    }
                }
            }
        }
    }
}


/*
 let DB_REF: DatabaseReference = Database.database().reference()

 let Users_REF: DatabaseReference = DB_REF.child("users")
 let Diary_REF: DatabaseReference = DB_REF.child("diarys")
 let Image_REF: DatabaseReference = DB_REF.child("haveImg")
 let imgFont_REF: DatabaseReference = DB_REF.child("current-ImgFont")


*/
