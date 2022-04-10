//
//  ChampionSkinSplashCollectionViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 4/7/22.
//

import UIKit

class ChampionSkinSplashCollectionViewController: UICollectionViewController {

    
    var character: ChampionData?
    var skin: Skins?
    var skins: [Skins] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSplashes()
        updateViews()


    }
    
    func updateViews() {
        collectionView.reloadData()
    }
    
    func fetchSplashes() {
        
        guard let character = character else { return }
        ChampionController.fetchStandAloneChampion(championName: character.name) { result in
            switch result {
            case .success(let character):
                self.character = character
                
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return character?.skins.count ?? 0
//    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return character?.skins.count ?? 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skinCell", for: indexPath) as? ChampionSkinCollectionViewCell else { return UICollectionViewCell() }
    
        let skin = character?.skins[indexPath.row]
        
        cell.character = character
        cell.skin = skin
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let oneCellWidth = view.frame.width * 0.45
        
        let cellsTotalWidth = oneCellWidth * 2
        
        let leftoverWidth = view.frame.width - cellsTotalWidth
        
        //leftover = view.frame.width * 0.1
        
        let inset = leftoverWidth / 3
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
}
