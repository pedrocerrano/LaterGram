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
    func saveToFirebase(username: String, message: String, image: UIImage, completion: @escaping () -> Void)
    func loadFromFirestore(completion: @escaping (Result<[Gram], FirebaseError>) -> Void)
    func deleteGram(from gram: Gram, completion: @escaping () -> Void)
    
    func saveImage(_ image: UIImage, withUUID uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void)
    func fetchImage(from gram: Gram, completion: @escaping (Result<UIImage, FirebaseError>) -> Void)
    func deleteImage(from gram: Gram)
    func updateImage(_ gram: Gram, withImage newImage: UIImage, completion: @escaping () -> Void)
}

struct FirebaseService: FirebaseSyncable {
    
    //MARK: - PROPERTIES
    let ref     = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    
    //MARK: - MODEL FUNCTIONS
    func saveToFirebase(username: String, message: String, image: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
        saveImage(image, withUUID: uuid) { result in
            switch result {
            case .success(let imageURL):
                let gram = Gram(username: username, gramMessage: message, gramPhotoURL: imageURL.absoluteString, gramUUID: uuid)
                ref.collection(Gram.Key.collectionType).document(gram.gramUUID).setData(gram.dictionaryRepresentation)
                completion()
            case .failure(let savingFailure):
                print("Failed saving to Firebase: \(savingFailure)")
            }
        }
    }
    
    func loadFromFirestore(completion: @escaping (Result<[Gram], FirebaseError>) -> Void) {
        ref.collection(Gram.Key.collectionType).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let data = snapshot?.documents else { completion(.failure(.noDataFound)) ; return }
            let dictionaryArray = data.compactMap { $0.data() }
            let gramInfo = dictionaryArray.compactMap { Gram(fromDictionary: $0) }
            completion(.success(gramInfo))
        }
    }
    
    func deleteGram(from gram: Gram, completion: @escaping () -> Void) {
        ref.collection(Gram.Key.collectionType).document(gram.gramUUID).delete()
        deleteImage(from: gram)
        completion()
    }
    
    
    //MARK: - FIRESTORE IMAGE FUNCTIONS
    func saveImage(_ image: UIImage, withUUID uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        let uploadImageData = StorageMetadata()
        uploadImageData.contentType = "image/jpeg"
        
        let uploadTask = storage.child(Gram.Key.storageRef).child(uuidString).putData(imageData, metadata: uploadImageData) { _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        
        uploadTask.observe(.success) { _ in
            print("Image uploaded to Firebase")
            self.storage.child(Gram.Key.storageRef).child(uuidString).downloadURL { url, error in
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
    
    func fetchImage(from gram: Gram, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(Gram.Key.storageRef).child(gram.gramUUID).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { completion(.failure(.unableToDecodeData)) ; return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
            }
        }
    }
    
    func deleteImage(from gram: Gram) {
        storage.child(Gram.Key.storageRef).child(gram.gramUUID).delete(completion: nil)
    }
    
    func updateImage(_ gram: Gram, withImage newImage: UIImage, completion: @escaping () -> Void) {
        saveImage(newImage, withUUID: gram.gramUUID) { result in
            switch result {
            case .success(_):
                ref.collection(Gram.Key.collectionType).document(gram.gramUUID).setData(gram.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
}
