//
//  FirebaseService.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case firebaseError(Error)
    case unableToDecodeData
    case noDataFound
}

protocol FirebaseSyncable {
    func saveToFirebase(username: String, message: String, image: UIImage)
    func loadFromFirestore(completion: @escaping (Result<[User], FirebaseError>) -> Void)
    func deleteGram(from user: User)
    
    func saveImage(_ image: UIImage, withUUID uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void)
    func fetchImage(from user: User, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func deleteImage(from user: User)
    func updateImage(_ user: User, withImage newImage: UIImage)
}

struct FirebaseService: FirebaseSyncable {
    
    //MARK: - PROPERTIES
    let ref     = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    
    //MARK: - MODEL FUNCTIONS
    func saveToFirebase(username: String, message: String, image: UIImage) {
#warning("Don't forget the completion if it takes time to reload cell after popping")
        
        let uuid = UUID().uuidString
        saveImage(image, withUUID: uuid) { result in
            switch result {
            case .success(let imageURL):
                let user = User(username: username, gramMessage: message, gramPhotoURL: imageURL.absoluteString, gramUUID: uuid)
                ref.collection(User.Key.collectionType).document(user.gramUUID).setData(user.dictionaryRepresentation)
            case .failure(let savingFailure):
                print("Failed saving to Firebase: \(savingFailure)")
            }
        }
    }
    
    func loadFromFirestore(completion: @escaping (Result<[User], FirebaseError>) -> Void) {
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
    
    func deleteGram(from user: User) {
        ref.collection(User.Key.collectionType).document(user.gramUUID).delete()
        deleteImage(from: user)
    }
    
    
    //MARK: - FIRESTORE IMAGE FUNCTIONS
    func saveImage(_ image: UIImage, withUUID uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        let uploadImageData = StorageMetadata()
        uploadImageData.contentType = "image/jpeg"
        
        let uploadTask = storage.child(User.Key.storageRef).child(uuidString).putData(imageData, metadata: uploadImageData) { _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        
        uploadTask.observe(.success) { _ in
            print("Image uploaded to Firebase")
            self.storage.child(User.Key.storageRef).child(uuidString).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.firebaseError(error)))
                    return
                }
                
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.firebaseError(snapshot.error!)))
            return
        }
    }
    
    func fetchImage(from user: User, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(User.Key.storageRef).child(user.gramUUID).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { completion(.failure(.unableToDecodeData)) ; return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
            }
        }
    }
    
    func deleteImage(from user: User) {
        storage.child(User.Key.storageRef).child(user.gramUUID).delete(completion: nil)
    }
    
    func updateImage(_ user: User, withImage newImage: UIImage) {
#warning("Don't forget the completion if it takes time to reload cell after popping")
        saveImage(newImage, withUUID: user.gramUUID) { result in
            switch result {
            case .success(_):
                ref.collection(User.Key.collectionType).document()
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
}
