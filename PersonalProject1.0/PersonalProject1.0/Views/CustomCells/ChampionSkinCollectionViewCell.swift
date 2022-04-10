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
        
        
        ChampionController.fetchSkinSplashesFor(championName: character?.name ?? "", skinNumber: skin.num) { result in
            switch result {
            case .success(let image):
                self.skinImageView.image = image
                self.skinImageView.layer.cornerRadius = self.frame.height / 2.0
            case .failure(_):
                self.skinImageView.image = UIImage(systemName: "square")
            }
        }
    }
    
}
