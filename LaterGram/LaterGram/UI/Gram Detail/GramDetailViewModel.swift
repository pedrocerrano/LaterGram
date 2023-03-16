//
//  GramDetailViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import UIKit

#warning("Might need a protocol")

struct GramDetailViewModel {
    
    //MARK: - PROPERTIES
    var user: User?
    let service: FirebaseSyncable
    
    init(user: User? = nil, service: FirebaseSyncable = FirebaseService()) {
        self.user = user
        self.service = service
    }
    
    //MARK: - FUNCTIONS
    func save(username: String = "HappyDaddy", gramMessage: String, gramPhoto: UIImage) {
        if let user = user {
            user.username    = username
            user.gramMessage = gramMessage
            service.updateImage(user, withImage: gramPhoto)
#warning("Remeber completion")
        } else {
            service.saveToFirebase(username: username, message: gramMessage, image: gramPhoto)
#warning("Remeber completion")
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let user = user else { return }
        service.fetchImage(from: user) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
