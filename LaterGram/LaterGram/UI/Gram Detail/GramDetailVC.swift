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
        guard let gram = detailViewModel.gram else { return }
        gramMessageTextView.text = gram.gramMessage
        detailViewModel.getImage { image in
            self.gramImageView.image = image
        }
    }
    
    func configureDesignElements() {
        gramImageView.layer.shadowColor   = Constants.Configure.shadowColor
        gramImageView.layer.shadowOpacity = Constants.Configure.shadowOpacity
        gramImageView.layer.shadowRadius  = Constants.Configure.shadowRadius
        gramImageView.layer.masksToBounds = Constants.Configure.masksToBounds
        gramImageView.layer.borderColor   = Constants.Configure.borderColor
        gramImageView.layer.borderWidth   = Constants.Configure.borderWidth
        gramImageView.backgroundColor     = Constants.Configure.backgroundColor
        
        gramMessageTextView.layer.shadowColor   = Constants.Configure.shadowColor
        gramMessageTextView.layer.shadowOpacity = Constants.Configure.shadowOpacity
        gramMessageTextView.layer.shadowRadius  = Constants.Configure.shadowRadius
        gramMessageTextView.layer.masksToBounds = Constants.Configure.masksToBounds
        gramMessageTextView.layer.borderColor   = Constants.Configure.borderColor
        gramMessageTextView.layer.borderWidth   = Constants.Configure.borderWidth
        gramMessageTextView.backgroundColor     = Constants.Configure.backgroundColor
        
        deleteGramButton.layer.shadowColor   = Constants.Configure.shadowColor
        deleteGramButton.layer.shadowOpacity = Constants.Configure.shadowOpacity
        deleteGramButton.layer.shadowRadius  = Constants.Configure.shadowRadius
        deleteGramButton.layer.masksToBounds = Constants.Configure.masksToBounds
        deleteGramButton.layer.borderColor   = Constants.Configure.borderColor
        deleteGramButton.layer.borderWidth   = Constants.Configure.borderWidth
        deleteGramButton.backgroundColor     = Constants.Configure.backgroundColor
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
    func gramSuccessfullyHandled() {
        self.navigationController?.popViewController(animated: true)
    }
}
