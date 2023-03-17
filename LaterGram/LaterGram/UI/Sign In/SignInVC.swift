//
//  SignInVC.swift
//  LaterGram
//
//  Created by iMac Pro on 3/16/23.
//

import UIKit

class SignInVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var signInEmailTextField: UITextField!
    @IBOutlet weak var signInPasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    //MARK: - PROPERTIES
    var signInViewModel: SignInViewModel!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        signInViewModel = SignInViewModel()
        configureUI()
    }

    
    //MARK: - FUNCTIONS
    func configureUI() {
        let gradient = signInViewModel.gradientLayer
        let red      = UIColor.systemRed.cgColor
        let blue     = UIColor.systemBlue.cgColor
        gradient.colors = [blue, red]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        signInButton.layer.cornerRadius  = Constants.Configure.cornerRadius
        signInButton.layer.shadowColor   = Constants.Configure.shadowColor
        signInButton.layer.shadowOpacity = Constants.Configure.shadowOpacity
        signInButton.layer.shadowRadius  = Constants.Configure.shadowRadius
        signInButton.layer.masksToBounds = Constants.Configure.masksToBounds

        createAccountButton.layer.cornerRadius  = Constants.Configure.cornerRadius
        createAccountButton.layer.shadowColor   = Constants.Configure.shadowColor
        createAccountButton.layer.shadowOpacity = Constants.Configure.shadowOpacity
        createAccountButton.layer.shadowRadius  = Constants.Configure.shadowRadius
        createAccountButton.layer.masksToBounds = Constants.Configure.masksToBounds
    }
    
    
    //MARK: - IB OUTLETS
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = signInEmailTextField.text,
              let password = signInPasswordTextField.text else { return }
        signInViewModel.signIn(withEmail: email, withPassword: password)
    }
    
}
