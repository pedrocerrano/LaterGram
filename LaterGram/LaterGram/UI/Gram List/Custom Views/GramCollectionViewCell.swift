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
    func configureUI() {
        gramImageView.image = UIImage(named: "kids")
        gramUsernameLabel.text = "HappyDaddy"
        gramDateLabel.text = "March 14, 2023"
        gramMessageLabel.text = "Being a Husband and a Daddy are two of the greatest joys of my life! Being a Husband and a Daddy are two of the greatest joys of my life! Being a Husband and a Daddy are two of the greatest joys of my life! Being a Husband and a Daddy are two of the greatest joys of my life!"
    }
    
}
