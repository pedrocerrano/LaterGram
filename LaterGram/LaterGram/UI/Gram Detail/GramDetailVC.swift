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
        setupImageView()
    }

    //MARK: - IB ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let gramMessage = gramMessageTextView.text,
              let image = gramImageView.image else { return }
        detailViewModel.save(gramMessage: gramMessage, gramPhoto: image)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - FUNCTIONS
    private func updateUI() {
        guard let user = detailViewModel.user else { return }
        gramMessageTextView.text = user.gramMessage

        detailViewModel.getImage { image in
            self.gramImageView.image = image
        }
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
