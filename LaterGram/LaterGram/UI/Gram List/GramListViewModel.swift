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
    var grams: [Gram] = []
    private var service: FirebaseSyncable
    private weak var delegate: GramListViewModelDelegate?
    
    init(service: FirebaseSyncable = FirebaseService(), delegate: GramListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    //MARK: - FUNCTIONS
    func loadGrams() {
        service.loadFromFirestore { [weak self] result in
            switch result {
            case .success(let grams):
                self?.grams = grams
                self?.delegate?.dataLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
