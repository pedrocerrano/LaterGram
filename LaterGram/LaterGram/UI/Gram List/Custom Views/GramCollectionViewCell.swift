//
//  GramCollectionViewCell.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

class GramCollectionViewCell: UICollectionViewCell {
    
    //MARK: - OUTLETS
    @IBOutlet weak var gramImageView: UIImageView!
    @IBOutlet weak var gramUsernameLabel: UILabel!
    @IBOutlet weak var gramMessageLabel: UILabel!
    @IBOutlet weak var gramDateLabel: UILabel!
    
    
    //MARK: - PROPERTIES
    let service = FirebaseService()
    
    
    //MARK: - FUNCTIONS
    func configureUI(withUser user: User) {
        gramUsernameLabel.text  = user.username
        gramDateLabel.text      = user.gramCreationDate.stringValue()
        gramMessageLabel.text   = user.gramMessage
        
        service.fetchImage(from: user) { result in
            switch result {
            case .success(let image):
                self.gramImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

