//
//  ItemsCollectionViewCell.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/2/21.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    //MARK: - Properties
    var items: Items? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Helper funcs
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//
//        if #available(iOS 15.0, *) {
//            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//                if traitCollection.userInterfaceStyle == .dark {
//                    itemLabel.textColor = UIColor.white
//                    itemLabel.backgroundColor = UIColor.lightGray
//                    //Dark
//                }
//                else {
//                    //Light
//                    itemLabel.textColor = UIColor.black
//                    itemLabel.backgroundColor = UIColor.lightGray
//
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
//    }
    func updateViews() {
        guard let item = items else { return }
        
        
        let underlineAttriString = NSAttributedString(string: item.name,
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        itemLabel.attributedText = underlineAttriString
        
        ItemController.fethItemImage(items: item) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.itemImageView.image = image
                    self.itemImageView.layer.cornerRadius = self.frame.height / 2.0
                case .failure(_):
                    self.itemImageView.image = UIImage(systemName: "square")
                }
            }
        }
    }//end of func

    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = UIImage(systemName: "square")
    
    }//end of func
    
}//end of class

