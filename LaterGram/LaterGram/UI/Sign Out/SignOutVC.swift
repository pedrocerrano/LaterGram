//
//  SignOutVC.swift
//  LaterGram
//
//  Created by iMac Pro on 3/16/23.
//

import UIKit

class SignOutVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var signOutButton: UIButton!
    
    
    //MARK: - PROPERTIES
    var outViewModel: SignOutViewModel!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        outViewModel = SignOutViewModel()
        configureUI()
    }

    
    //MARK: - IB ACTIONS
    @IBAction func signOutButtonTapped(_ sender: Any) {
        outViewModel.signOut()
    }
    
    
    //MARK: - FUNCTIONS
    func configureUI() {
        let gradient = outViewModel.gradientLayer
        let red      = UIColor.systemRed.cgColor
        let blue     = UIColor.systemBlue.cgColor
        gradient.colors = [blue, red]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        signOutButton.layer.cornerRadius  = Constants.Configure.cornerRadius
        signOutButton.layer.shadowColor   = Constants.Configure.shadowColor
        signOutButton.layer.shadowOpacity = Constants.Configure.shadowOpacity
        signOutButton.layer.shadowRadius  = Constants.Configure.shadowRadius
        signOutButton.layer.masksToBounds = Constants.Configure.masksToBounds
    }
    
}
