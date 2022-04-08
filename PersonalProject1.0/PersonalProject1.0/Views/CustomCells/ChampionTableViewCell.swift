//
//  ChampionTableViewCell.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 10/7/21.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var championImage: UIImageView!
    @IBOutlet weak var championNameLabel: UILabel!
    @IBOutlet weak var championTitleLabel: UILabel!
    

    //MARK: - Properties
    var champions: ChampionInfo? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Cell functions
    override func prepareForReuse() {
        super.prepareForReuse()
        championImage.image = UIImage()
        championImage.layer.cornerRadius = 43.5
        championNameLabel.text = ""
        championTitleLabel.text = ""
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
    //MARK: - Helper funcs
    func updateViews() {
        guard let champion = champions else { return }
        
        let underlineAttriString = NSAttributedString(string: champion.name,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            championNameLabel.attributedText = underlineAttriString
        championTitleLabel.text = champion.title
//        championNameLabel.textColor = .white
        //nameLabel.highlightedTextColor = .black
        
        ChampionController.fetchImageFor(championInfo: champion) { result in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let image):
                    self.championImage.image = image
                    self.championImage.layer.cornerRadius = 43.5
                case .failure(_):
                    self.championImage.image = UIImage(systemName: "square")
                }
            }
        }
    }//End of func

}//End of class
