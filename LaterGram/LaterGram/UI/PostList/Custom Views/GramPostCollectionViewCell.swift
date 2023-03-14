//
//  GramPostCollectionViewCell.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

class GramPostCollectionViewCell: UICollectionViewCell {
    
    //MARK: - OUTLETS
    @IBOutlet weak var gramPostImageView: UIImageView!
    @IBOutlet weak var gramPostUsernameLabel: UILabel!
    @IBOutlet weak var gramPostMessageLabel: UILabel!
    @IBOutlet weak var gramPostDateLabel: UILabel!
    
    
    //MARK: - FUNCTIONS
    func configureUI() {
        gramPostImageView.image = UIImage(named: "kids")
        gramPostUsernameLabel.text = "HappyDaddy"
        gramPostDateLabel.text = "March 14, 2023"
        gramPostMessageLabel.text = "Being a Husband and a Daddy are two of the greatest joys of my life! Being a Husband and a Daddy are two of the greatest joys of my life!"
    }
    
}
