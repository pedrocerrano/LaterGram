//
//  GramDetailViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import Foundation

struct GramDetailViewModel {
    
    //MARK: - PROPERTIES
    var user: User?
    let service: FirebaseSyncable
    
    init(user: User? = nil, service: FirebaseSyncable = FirebaseService()) {
        self.user = user
        self.service = service
    }
    
    //MARK: - FUNCTIONS
    func save(username: String = "HappyDaddy", gramMessage: String, gramPhoto: String = "kids") {
        if user != nil {
            updateUser(withMessage: gramMessage, withPhoto: gramPhoto)
        } else {
            let user = User(username: username, gramMessage: gramMessage, gramPhoto: gramPhoto)
            service.saveToFirestore(user: user)
        }
    }
    
    private func updateUser(withMessage message: String, withPhoto photo: String) {
        guard let user = user else { return }
        user.gramMessage = message
        user.gramPhoto   = photo
        service.saveToFirestore(user: user)
    }
}
