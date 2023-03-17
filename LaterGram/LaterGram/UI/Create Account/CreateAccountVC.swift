//
//  CreateAccountVC.swift
//  LaterGram
//
//  Created by iMac Pro on 3/16/23.
//

import UIKit

class CreateAccountVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var createUserEmailTextField: UITextField!
    @IBOutlet weak var createUserPasswordTextField: UITextField!
    @IBOutlet weak var createUserVerifyPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    //MARK: - PROPERTIES
    var createAccountViewModel: CreateAccountViewModel!
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountViewModel = CreateAccountViewModel()
        configureUI()
    }
    
    
    //MARK: - IB ACTIONS
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = createUserEmailTextField.text,
              let password = createUserPasswordTextField.text,
              let verifyPassword = createUserVerifyPasswordTextField.text else { return }
        
        createAccountViewModel.createAccount(email: email, password: password, verifyPassword: verifyPassword)
    }
    
    
    //MARK: - FUNCTIONS
    func configureUI() {
        let gradient = createAccountViewModel.gradientLayer
        let red      = UIColor.systemRed.cgColor
        let blue     = UIColor.systemBlue.cgColor
        gradient.colors = [red, blue]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        signUpButton.layer.cornerRadius  = 6
        signUpButton.layer.shadowColor   = Constants.Configure.shadowColor
        signUpButton.layer.shadowOpacity = Constants.Configure.shadowOpacity
        signUpButton.layer.shadowRadius  = Constants.Configure.shadowRadius
        signUpButton.layer.masksToBounds = Constants.Configure.masksToBounds
    }
    
} //: CLASS
