//
//  MessageFirestore.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 26/10/21.
//  Copyright © 2021 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

public class MessageFirestore: MessageManager {
    
    public var discussion: Discussion
    var ref: CollectionReference
    
    public required init(discussion: Discussion) {
        self.discussion = discussion
        self.ref = Firestore.firestore().collection(self.discussion.uid)
    }
    
    public func list(onSuccess: @escaping ([Message]) -> Void, onError: ErrorClosure?) {
        
        self.ref.order(by: "sentDate").addSnapshotListener { snapshot, error in
            
            if let err = error, let retError = onError{
                retError(err)
            }
            
            if let snap = snapshot {
                let messages = snap.documents
                    .compactMap({ Message.mapperFirestore(json: $0) })
                
                onSuccess(messages)
            }
            
            
        }
        
    }
    
    public func add(message: Message, onSuccess: @escaping () -> Void, onError: ErrorClosure?) {
        
        let document = Message.toDict(message: message)
        
        self.ref.addDocument(data: document) { error in
            
            if let err = error, let retError = onError {
                retError(err)
            }
            
            onSuccess()
            
        }
        
    }
    
    
    
    
}
