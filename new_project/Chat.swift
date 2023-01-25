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
    var isOnline: Bool 
}

struct Photo {
    let photo: String
}

struct Emotion {
    let emotion: String
}
    

