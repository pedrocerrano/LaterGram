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
    
    
    //MARK: - FUNCTIONS
    func configureUI(withUser user: User) {
        gramImageView.image     = UIImage(named: user.gramPhoto ?? "kids")
        gramUsernameLabel.text  = user.username
        gramDateLabel.text      = user.gramCreationDate.stringValue()
        gramMessageLabel.text   = user.gramMessage
    }
    
}
