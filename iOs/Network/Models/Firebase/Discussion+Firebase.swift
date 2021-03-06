//
//  Discussion+Firebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 25/10/21.
//  Copyright © 2021 ERISCO. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension Discussion {
    
    class func mapper(snapshot: DataSnapshot) -> Discussion? {
        
        guard let json = snapshot.value as? [String:Any] else {
            return nil
        }
        
        let uid = json["uid"] as? String ?? ""
        let title = json["title"] as? String ?? ""
        
        return Discussion.init(uid: uid, title: title)
        
    }
    
}
