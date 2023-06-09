//
//  GramListCollectionViewController.swift
//  LaterGram
//
//  Created by iMac Pro on 3/13/23.
//

import UIKit

class GramListCollectionViewController: UICollectionViewController {
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GramListViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadGrams()
    }
    
    
    //MARK: - PROPERTIES
    var viewModel: GramListViewModel!
    
    
    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.grams.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gramsCell", for: indexPath) as? GramCollectionViewCell else { return UICollectionViewCell() }
        
        let gram = viewModel.grams[indexPath.item]
        cell.configureUI(withGram: gram)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    
    //MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? GramDetailVC else { return }
        if segue.identifier == "toGramPostDetailVC" {
                  guard let index = collectionView.indexPathsForSelectedItems?.first else { print("Issue with segue.") ; return }
            let gram = viewModel.grams[index.item]
            destinationVC.detailViewModel = GramDetailViewModel(gram: gram, delegate: destinationVC.self)
        } else {
            destinationVC.detailViewModel = GramDetailViewModel(delegate: destinationVC.self)
        }
    }
} //: CLASS


// MARK: - EXT: CollectionViewFlowLayout
extension GramListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        return CGSize(width: width, height: width - 40)
    }
}


//MARK: - EXT: ViewModelDelegate
extension GramListCollectionViewController: GramListViewModelDelegate {
    func dataLoadedSuccessfully() {
        collectionView.reloadData()
    }
}
