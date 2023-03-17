//
//  SignOutViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/16/23.
//

import UIKit
import FirebaseAuth

struct SignOutViewModel {
    
    //MARK: - PROPERTIES
    var gradientLayer = CAGradientLayer()
    
    
    //MARK: - FUNCTIONS
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
