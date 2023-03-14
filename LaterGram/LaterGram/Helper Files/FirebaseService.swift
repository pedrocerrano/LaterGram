//
//  FirebaseService.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: Error {
    case firebaseError(Error)
    case unableToDecodeData
    case noDataFound
}

protocol FirebaseSyncable {
    func saveToFirestore(user: User)
    func loadGramsFromFirestore(completion: @escaping (Result<[User], FirebaseError>) -> Void)
    func delete(user: User)
}

struct FirebaseService {
    let ref = Firestore.firestore()
    
    func saveToFirestore(user: User) {
        ref.collection(User.Key.collectionType).document(user.gramUUID).setData(user.dictionaryRepresentation)
    }
    
    func loadGramsFromFirestore(completion: @escaping (Result<[User], FirebaseError>) -> Void) {
        ref.collection(User.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let data = snapshot?.documents else { completion(.failure(.noDataFound)) ; return }
            let dictionaryArray = data.compactMap { $0.data() }
            let userInfo = dictionaryArray.compactMap { User(fromDictionary: $0) }
            completion(.success(userInfo))
        }
    }
    
    func delete(user: User) {
        ref.collection(User.Key.collectionType).document(user.gramUUID).delete()
    }
}
