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
    @IBOutlet weak var deleteGramButton: UIButton!
    
    
    //MARK: - PROPERTIES
    var detailViewModel: GramDetailViewModel!

    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupImageView()
    }

    //MARK: - IB ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let gramMessage = gramMessageTextView.text,
              let image       = gramImageView.image else { return }
        detailViewModel.save(message: gramMessage, gramPhoto: image)
    }
    
    @IBAction func deleteGramButtonTapped(_ sender: Any) {
        detailViewModel.deleteGram()
    }
    
    
    //MARK: - FUNCTIONS
    private func updateUI() {
        configureDesignElements()
        guard let user = detailViewModel.user else { return }
        gramMessageTextView.text = user.gramMessage
        detailViewModel.getImage { image in
            self.gramImageView.image = image
        }
    }
    
    func configureDesignElements() {
        gramImageView.layer.shadowColor   = UIColor.black.cgColor
        gramImageView.layer.shadowOpacity = 0.2
        gramImageView.layer.shadowRadius  = 7
        gramImageView.layer.masksToBounds = false
        gramImageView.layer.borderColor   = UIColor.white.cgColor
        gramImageView.layer.borderWidth   = 1
        gramImageView.backgroundColor     = .systemBackground
        
        gramMessageTextView.layer.shadowColor   = UIColor.black.cgColor
        gramMessageTextView.layer.shadowOpacity = 0.2
        gramMessageTextView.layer.shadowRadius  = 7
        gramMessageTextView.layer.masksToBounds = false
        gramMessageTextView.layer.borderColor   = UIColor.white.cgColor
        gramMessageTextView.layer.borderWidth   = 1
        gramMessageTextView.backgroundColor     = .systemBackground
        
        deleteGramButton.layer.shadowColor   = UIColor.black.cgColor
        deleteGramButton.layer.shadowOpacity = 0.2
        deleteGramButton.layer.shadowRadius  = 7
        deleteGramButton.layer.masksToBounds = false
        deleteGramButton.layer.borderColor   = UIColor.white.cgColor
        deleteGramButton.layer.borderWidth   = 1
        deleteGramButton.backgroundColor     = .systemBackground
        
    }
    
    
    //MARK: - TAP GESTURE
    func setupImageView() {
        gramImageView.contentMode = .scaleAspectFit
        gramImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        gramImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
} //: CLASS


//MARK: - EXT: IMAGE PICKER
extension GramDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        gramImageView.image = image
    }
}


//MARK: - EXT: GramDetailViewModelDelegate
extension GramDetailVC: GramDetailViewModelDelegate {
    func userGramSuccessfullyHandled() {
        self.navigationController?.popViewController(animated: true)
    }
}
