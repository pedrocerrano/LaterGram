//
//  GramDetailViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import UIKit

protocol GramDetailViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()
}

struct GramDetailViewModel {
    
    //MARK: - PROPERTIES
    var user: User?
    let service: FirebaseSyncable
    private weak var delegate: GramDetailViewModelDelegate?
    
    init(user: User? = nil, service: FirebaseSyncable = FirebaseService(), delegate: GramDetailViewModelDelegate) {
        self.user     = user
        self.service  = service
        self.delegate = delegate
    }
    
    //MARK: - FUNCTIONS
    func save(username: String = "HappyDaddy", message: String, gramPhoto: UIImage) {
        if let user = user {
            user.username    = username
            user.gramMessage = message
            service.updateImage(user, withImage: gramPhoto) {
                self.delegate?.imageSuccessfullySaved()
            }
        } else {
            service.saveToFirebase(username: username, message: message, image: gramPhoto) {
                self.delegate?.imageSuccessfullySaved()
            }
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
