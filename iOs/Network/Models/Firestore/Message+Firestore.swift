//
//  Message+Firestore.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 26/10/21.
//  Copyright © 2021 ERISCO. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MessageKit

extension Message {
    
    public class func mapperFirestore(json: QueryDocumentSnapshot) -> Message? {
        
        let senderId = json["senderId"] as? String ?? ""
        let displayName = json["displayName"] as? String ?? ""
        let sender = Sender.init(senderId: senderId, displayName: displayName)
        
        let messageId = json["messageId"] as? String ?? ""
        
        let dateString = json["sentDate"] as? String ?? ""
        let sentDate = Date.fromStringToDate(input: dateString, format: "yyyy-MM-dd HH:mm:ss")
        
        let value = json["value"] as? String ?? ""
        let type = json["type"] as? String ?? ""
        
        let messageData: MessageKind
        
        switch type {
        case "text":
            messageData = MessageKind.text(value)
        case "image":
            let placeHolder = UIImage.init(named: "diehard")
            let mediaItem = ImageMediaItem.init(image: placeHolder!)
            messageData = MessageKind.photo(mediaItem)
        default:
            messageData = MessageKind.text(value)
        }
        
        let message = Message.init(sender: sender,
                                   messageId: messageId,
                                   sentDate: sentDate,
                                   kind: messageData,
                                   type: type,
                                   value: value)
        
        return message
        
    }
    
    
}

