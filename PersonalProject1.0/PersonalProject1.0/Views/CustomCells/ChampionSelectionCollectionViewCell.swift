//
//  ChampionSelectionCollectionViewCell.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 2/8/22.
//

import UIKit

class ChampionSelectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet var championImageView: UIImageView!
    @IBOutlet var championNameLabel: UILabel!
    
    //MARK: - Properties
    var champions: ChampionInfo? {
        didSet {
            updateViews()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        championImageView.image = UIImage(systemName: "square")
    }
    
    
    //MARK: - Helper Funcs
    
    func updateViews() {
        guard let champion = champions else { return }
        
        let underlineAttriString = NSAttributedString(string: champion.name,
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        championNameLabel.attributedText = underlineAttriString
        
        ChampionController.fetchImageFor(championInfo: champion) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let champion):
                    self.championImageView.image = champion
                    self.championImageView.layer.cornerRadius = self.frame.height / 2.0
                case .failure(_):
                    self.championImageView.image = UIImage(systemName: "square")
                }
            }
        }
    }//End of func
}//End of class
