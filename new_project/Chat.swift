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
    let message: String
    let image: Photo
    let emotion: Emotion
    let timeOfEvent: String
    let lastMessage: String
}

struct Photo {
    let photo: String
}

struct Emotion {
    let emotion: String
}
    
//    init(name: [String], login: [String], message: [String], image: [String], emotion: [String], section: String, timeOfEvent: [String], lastMessage: [String], isExpandable: Bool) {
//        self.name = name
//        self.login = login
//        self.message = message
//        self.image = image
//        self.emotion = emotion
//        self.section = section
//        self.timeOfEvent = timeOfEvent
//        self.lastMessage = lastMessage
//        self.isExpandable = isExpandable
//    }

