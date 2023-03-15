//
//  GramDetailVC.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import UIKit

class GramDetailVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var gramImageView: UIImageView!
    @IBOutlet weak var gramMessageTextView: UITextView!
    
    
    //MARK: - PROPERTIES
    var detailViewModel: GramDetailViewModel!
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - IB ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let gramMessage = gramMessageTextView.text else { return }
        detailViewModel.save(gramMessage: gramMessage)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - FUNCTIONS
    private func updateUI() {
        guard let user = detailViewModel.user else { return }
        gramImageView.image = UIImage(named: user.gramPhotoURL)
        gramMessageTextView.text = user.gramMessage
    }
}
