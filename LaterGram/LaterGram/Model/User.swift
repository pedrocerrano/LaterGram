//
//  User.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

struct User: Decodable {
    let username: String
    let gramPosts: [GramPost]
}

struct GramPost: Decodable {
    var gramPostMessage: String
    var gramPostPhoto: String?
    let gramPostCreationDate: Date
    let gramPostComments: [Comment]
    let gramPostUUID: UUID
}

struct Comment: Decodable {
    var commentMessage: String
    var commentCreationDate: Date
    let commentUUID: UUID
}
