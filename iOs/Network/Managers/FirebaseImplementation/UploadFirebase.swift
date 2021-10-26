//
//  UploadFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 26/10/21.
//  Copyright © 2021 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

public class UploadFirebase: UploadManager {
    
    public func save(name: String, image: UIImage, onSuccess: @escaping (String) -> Void, onError: ErrorClosure?) {
        
        let ref = Storage.storage().reference().child("Chatkeepdoding").child(name)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.1) {
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            metadata.customMetadata = [ "user": "John Mcklayne" ]
            
            ref.putData(imageData, metadata: metadata) { metadata, error in
                
                if let err = error, let retError = onError {
                    retError(err)
                }
                
                ref.downloadURL { url, error in
                    
                    if let err = error, let retError = onError {
                        retError(err)
                    }
                    
                    onSuccess(url?.absoluteString ?? "")
                }
                
            }
        }
        
        
    }
    
}
