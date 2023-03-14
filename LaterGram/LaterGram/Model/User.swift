//
//  User.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

class User {
    
    enum Key {
        static let username             = "username"
        static let gramPostMessage      = "message"
        static let gramPostPhoto        = "photo"
        static let gramPostCreationDate = "date"
        static let gramPostUUID         = "UUID"
    }
    
    //MARK: - PROPERTIES
    let username: String
    var gramPostMessage: String
    var gramPostPhoto: String?
    let gramPostCreationDate: Date
    let gramPostUUID: String
    
    //MARK: - CREATING THE JSON
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.username             : self.username,
            Key.gramPostMessage      : self.gramPostMessage,
            Key.gramPostPhoto        : self.gramPostPhoto,
            Key.gramPostCreationDate : self.gramPostCreationDate,
            Key.gramPostUUID         : self.gramPostUUID
        ]
    }
    
    //MARK: - INITIALIZER
    init(username: String, gramPostMessage: String, gramPostPhoto: String? = nil, gramPostCreationDate: Date = Date(), gramPostUUID: String = UUID().uuidString) {
        self.username = username
        self.gramPostMessage = gramPostMessage
        self.gramPostPhoto = gramPostPhoto
        self.gramPostCreationDate = gramPostCreationDate
        self.gramPostUUID = gramPostUUID
    }
}

extension User {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let username = dictionary[Key.username] as? String,
              let message = dictionary[Key.gramPostMessage] as? String,
              let photo = dictionary[Key.gramPostPhoto] as? String,
              let date = dictionary[Key.gramPostCreationDate] as? Double,
              let uuid = dictionary[Key.gramPostUUID] as? String else {
            print("Failed to initialize object.")
            return nil
        }
        
        self.init(username: username, gramPostMessage: message, gramPostPhoto: photo, gramPostCreationDate: Date(timeIntervalSince1970: date), gramPostUUID: uuid)
    }
}


extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.gramPostUUID == rhs.gramPostUUID
    }
}
