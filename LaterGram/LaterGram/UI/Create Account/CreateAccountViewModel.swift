//
//  CreateAccountViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/16/23.
//

import UIKit
import FirebaseAuth

struct CreateAccountViewModel {
    
    //MARK: - PROPERTIES
    var gradientLayer = CAGradientLayer()
    
    
    //MARK: - FUNCTIONS
    func createAccount(email: String, password: String, verifyPassword: String) {
        if password == verifyPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let authResult = authResult {
                    let user = authResult.user
                    print(user.email ?? "Help!")
                }
            }
        } else {
            print("Passwords don't match.")
            #warning("Build Present Alert later")
        }
    }
}
