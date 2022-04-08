//
//  SearchBarCollectionReusableView.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/2/21.
//

import UIKit

class SearchBarCollectionReusableView: UICollectionReusableView {
  
    @IBOutlet weak var searchBar: UISearchBar!
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)

             return headerView
         }

         return UICollectionReusableView()

    }

}
