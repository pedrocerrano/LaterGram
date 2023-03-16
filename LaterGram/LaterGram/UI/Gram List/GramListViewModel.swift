//
//  GramListViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import Foundation

protocol GramListViewModelDelegate: AnyObject {
    func dataLoadedSuccessfully()
}

class GramListViewModel {
    
    //MARK: - PROPERTIES
    var users: [User] = []
    private var service: FirebaseSyncable
    private weak var delegate: GramListViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: GramListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    //MARK: - FUNCTIONS
    func loadUsers() {
        service.loadFromFirestore { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.delegate?.dataLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteGram(index: Int) {
        let user = users[index]
        service.deleteGram(from: user)
        self.users.remove(at: index)
    }
}
