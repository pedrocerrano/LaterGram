//
//  GramDetailViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import UIKit

protocol GramDetailViewModelDelegate: AnyObject {
    func gramSuccessfullyHandled()
}

struct GramDetailViewModel {
    
    //MARK: - PROPERTIES
    var gram: Gram?
    let service: FirebaseSyncable
    private weak var delegate: GramDetailViewModelDelegate?
    
    init(gram: Gram? = nil, service: FirebaseSyncable = FirebaseService(), delegate: GramDetailViewModelDelegate) {
        self.gram     = gram
        self.service  = service
        self.delegate = delegate
    }
    
    //MARK: - FUNCTIONS
    func save(username: String = "HappyDaddy", message: String, gramPhoto: UIImage) {
        if let gram = gram {
            gram.username    = username
            gram.gramMessage = message
            service.updateImage(gram, withImage: gramPhoto) {
                self.delegate?.gramSuccessfullyHandled()
            }
        } else {
            service.saveToFirebase(username: username, message: message, image: gramPhoto) {
                self.delegate?.gramSuccessfullyHandled()
            }
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let gram = gram else { return }
        service.fetchImage(from: gram) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func deleteGram() {
        guard let gram = gram else { return }
        service.deleteGram(from: gram) {
            self.delegate?.gramSuccessfullyHandled()
        }
    }
}
