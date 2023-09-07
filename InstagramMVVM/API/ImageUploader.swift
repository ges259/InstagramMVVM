//
//  ImageUploader.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    
    // MARK: - Upload_Image
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData) { metaData, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    print("downloadUrl error ----- \(error.localizedDescription)")
                }
                
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
