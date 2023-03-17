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
//            presentPasswordAlertController()
        }
    }
    
//    func presentPasswordAlertController() {
//        let view = UIViewController()
//        let alertController = UIAlertController(title: "Passwords Don't Match", message: "Make sure you type the same password in each field.", preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "OK", style: .default)
//        alertController.addAction(confirmAction)
//        view.present(alertController, animated: true)
//    }
}
