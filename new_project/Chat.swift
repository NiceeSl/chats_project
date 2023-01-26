//
//  Chat.swift
//  new_project
//
//  Created by work on 13.01.2023.
//

import Foundation

struct Section {
    let chats: [Chat] 
    let section: String
    var isExpandable: Bool = false
}

struct Chat {
    let name: String
    let login: String
    let message: Message
    let image: Photo
    let emotion: Emotion
    let startedAt: Date
    let completedAt: Date
    //let lastMessageDate:  [Message]
    var isOnline: Bool
    
    var isCompleted: Bool {
        Date() > completedAt
    }
}

struct Photo {
    let photo: String
}

struct Emotion {
    let emotion: String
}


struct Message {
    let text: String
    let messageDate: Date
}
    

