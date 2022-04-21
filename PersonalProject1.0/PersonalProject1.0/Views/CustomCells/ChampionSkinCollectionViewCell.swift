//
//  ChampionSkinCollectionViewCell.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 4/7/22.
//

import UIKit

class ChampionSkinCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var skinImageView: UIImageView!
    @IBOutlet var skinNameImageView: UILabel!
    
    var character: ChampionData?
    
    var skin: Skins? {
        didSet {
            updateViews()
        }
    }
    var skins: [Skins] = []
    
    
    func updateViews() {
        guard let skin = skin else { return }
        skinNameImageView.text = skin.name
        
        ChampionController.fetchSkinSplashesFor(championName: character?.name ?? "", skinNumber: skin.num) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.skinImageView.image = image
                    self.skinImageView.layer.cornerRadius = 20
                case .failure(_):
                    self.skinImageView.image = UIImage(systemName: "square")
                }
            }
        }
    }
}
