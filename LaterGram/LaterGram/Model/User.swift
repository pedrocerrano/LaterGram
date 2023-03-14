//
//  User.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

class User {
    
    enum Key {
        static let username         = "username"
        static let gramMessage      = "message"
        static let gramPhoto        = "photo"
        static let gramCreationDate = "date"
        static let gramUUID         = "UUID"
        static let collectionType   = "gramPosts"
    }
    
    //MARK: - PROPERTIES
    let username: String
    var gramMessage: String
    var gramPhoto: String?
    let gramCreationDate: Date
    let gramUUID: String
    
    //MARK: - CREATING THE JSON
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.username         : self.username,
            Key.gramMessage      : self.gramMessage,
            Key.gramPhoto        : self.gramPhoto,
            Key.gramCreationDate : self.gramCreationDate,
            Key.gramUUID         : self.gramUUID
        ]
    }
    
    //MARK: - INITIALIZER
    init(username: String, gramMessage: String, gramPhoto: String? = nil, gramCreationDate: Date = Date(), gramUUID: String = UUID().uuidString) {
        self.username = username
        self.gramMessage = gramMessage
        self.gramPhoto = gramPhoto
        self.gramCreationDate = gramCreationDate
        self.gramUUID = gramUUID
    }
}

extension User {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let username = dictionary[Key.username] as? String,
              let message = dictionary[Key.gramMessage] as? String,
              let photo = dictionary[Key.gramPhoto] as? String,
              let date = dictionary[Key.gramCreationDate] as? Double,
              let uuid = dictionary[Key.gramUUID] as? String else {
            print("Failed to initialize object.")
            return nil
        }
        
        self.init(username: username, gramMessage: message, gramPhoto: photo, gramCreationDate: Date(timeIntervalSince1970: date), gramUUID: uuid)
    }
}


extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.gramUUID == rhs.gramUUID
    }
}
