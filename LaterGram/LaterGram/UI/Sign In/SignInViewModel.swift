//
//  SignInViewModel.swift
//  LaterGram
//
//  Created by iMac Pro on 3/16/23.
//

import UIKit
import FirebaseAuth

struct SignInViewModel {
    
    //MARK: - PROPERTIES
    var gradientLayer = CAGradientLayer()
    
    
    //MARK: - FUNCTIONS
    func signIn(withEmail email: String, withPassword password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("Cannot sign in. Error: \(error.localizedDescription)")
            }
            
            if let result {
                let user = result.user
                print(user.email ?? "Email Not Found")
                print(user.uid)
            }
        }
    }
}
