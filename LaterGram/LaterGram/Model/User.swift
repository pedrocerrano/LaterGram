//
//  User.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

struct User: Decodable {
    let username: String
    let posts: [Post]
}

struct Post: Decodable {
    var postMessage: String
    var postPhoto: String?
    let postCreationDate: Date
    let postComments: [Comment]
    let postUUID: UUID
}

struct Comment: Decodable {
    var commentMessage: String
    var commentCreationDate: Date
    let commentUUID: UUID
}
