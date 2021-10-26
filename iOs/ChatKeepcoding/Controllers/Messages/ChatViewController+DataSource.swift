//
//  ChatViewController+DataSource.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 28/03/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import Foundation
import MessageKit

extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        return user.sender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.messages.count
    }
    
    
    func fetchMessages() {
        
        let manager = MessageInteractor.init(manager: MessageFirebase.init(discussion: self.actualDiscussion)).manager
        
        manager.list(onSuccess: { (messages) in
            self.messages = messages
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
        }) { (error) in
            print(error)
        }
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.messages[indexPath.section]
    }
}
