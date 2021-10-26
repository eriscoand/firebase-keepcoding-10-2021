//
//  Message+Firebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 26/10/21.
//  Copyright © 2021 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import MessageKit

extension Message {
    
    public class func mapper(snapshot: DataSnapshot) -> Message? {
        
        guard let json = snapshot.value as? [String:Any] else{
            return nil
        }
        
        let senderId = json["senderId"] as? String ?? ""
        let displayName = json["displayName"] as? String ?? ""
        let sender = Sender.init(senderId: senderId, displayName: displayName)
        
        let messageId = json["messageId"] as? String ?? ""
        
        let dateString = json["sentDate"] as? String ?? ""
        let sentDate = Date.fromStringToDate(input: dateString, format: "yyyy-MM-dd HH:mm:ss")
        
        let value = json["value"] as? String ?? ""
        let type = json["type"] as? String ?? ""
        
        let messageData = MessageKind.text(value)
        
        let message = Message.init(sender: sender,
                                   messageId: messageId,
                                   sentDate: sentDate,
                                   kind: messageData,
                                   type: type,
                                   value: value)
        
        return message
        
    }
    
    public class func toDict(message: Message) -> [String: String] {
        
        var dict = [String:String]()
        
        dict["senderId"] = message.sender.senderId
        dict["displayName"] = message.sender.displayName
        
        dict["messageId"] = message.messageId
        
        dict["sentDate"] = Date.fromDateToString(date: message.sentDate, format: "yyyy-MM-dd HH:mm:ss")
        
        dict["value"] = message.value
        dict["type"] = message.type
        
        return dict
        
    }
    
    
    
    
}
