//
//  BuildsTableViewCell.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/3/21.
//

import UIKit
import AVFoundation

protocol BuildsTableViewCellDelegate: AnyObject {
    func itemButtonTapped(button: Int, cell: BuildsTableViewCell)
 
    func championButtonTapped(button: Int, cell: BuildsTableViewCell)
}

class BuildsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemTwoButton: UIButton!
    @IBOutlet weak var itemOneButton: UIButton!
    @IBOutlet weak var itemThreeButton: UIButton!
    @IBOutlet weak var itemFourButton: UIButton!
    @IBOutlet weak var itemFiveButton: UIButton!
    @IBOutlet weak var itemSixButton: UIButton!
    @IBOutlet var championButton: UIButton!
    
    //MARK: - Properties
    var build: Build? {
        didSet {
            updateViews()
            
        }
    }
    
    var audioPlayer:AVPlayer!
    
    weak var delegate: BuildsTableViewCellDelegate?
    
    var itemButtons: [UIButton] {
        return [itemOneButton, itemTwoButton, itemThreeButton, itemFourButton, itemFiveButton, itemSixButton]
    }
    
    //MARK: - Actions
    @IBAction func itemButtonTapped(_ sender: UIButton) {
        delegate?.itemButtonTapped(button: sender.tag, cell: self)
        
    }
    @IBAction func championButtonTapped(_ sender: UIButton) {
        delegate?.championButtonTapped(button: sender.tag, cell: self)
    }
    
    
    //MARK: - helper funcs
    func updateViews() {
        guard let build = build else { return }
        if let itemOne = build.itemOne {
            ItemController.fethItemImage(items: itemOne) { result in
                DispatchQueue.main.async {
                    self.itemOneButton.setImage(try? result.get(), for: .normal)
//                    self.itemOneButton.setImage(try? result.get(), for: .normal)
                    self.itemOneButton.contentMode = .scaleAspectFill
                    self.itemOneButton.layer.cornerRadius = 20
                    self.itemOneButton.layer.borderWidth = 3
                    self.itemOneButton.layer.borderColor = UIColor.black.cgColor
                    self.itemOneButton.layer.masksToBounds = true
                }
            }
        } else {
            reset(itemOneButton)
        }
        
        if let itemTwo = build.itemTwo {
            ItemController.fethItemImage(items: itemTwo) { result in
                DispatchQueue.main.async {
                    self.itemTwoButton.setImage(try? result.get(), for: .normal)
                    self.itemTwoButton.contentMode = .scaleAspectFill
                    self.itemTwoButton.layer.cornerRadius = 20
                    self.itemTwoButton.layer.borderWidth = 3
                    self.itemTwoButton.layer.borderColor = UIColor.black.cgColor
                    self.itemTwoButton.layer.masksToBounds = true

                }
            }
        } else {
            reset(itemTwoButton)
        }
        
        if let itemThree = build.itemThree {
            ItemController.fethItemImage(items: itemThree) { result in
                DispatchQueue.main.async {
                    self.itemThreeButton.setImage(try? result.get(), for: .normal)
                    self.itemThreeButton.contentMode = .scaleAspectFill
                    self.itemThreeButton.layer.cornerRadius = 20
                    self.itemThreeButton.layer.borderWidth = 3
                    self.itemThreeButton.layer.borderColor = UIColor.black.cgColor
                    self.itemThreeButton.layer.masksToBounds = true
                }
            }
        } else {
            reset(itemThreeButton)
        }
        
        if let itemFour = build.itemFour {
            ItemController.fethItemImage(items: itemFour) { result in
                DispatchQueue.main.async {
                    self.itemFourButton.setImage(try? result.get(), for: .normal)
                    self.itemFourButton.contentMode = .scaleAspectFill
                    self.itemFourButton.layer.cornerRadius = 20
                    self.itemFourButton.layer.borderWidth = 3
                    self.itemFourButton.layer.borderColor = UIColor.black.cgColor
                    self.itemFourButton.layer.masksToBounds = true
                }
            }
        } else {
            reset(itemFourButton)
        }
        
        if let itemFive = build.itemFive {
            ItemController.fethItemImage(items: itemFive) { result in
                DispatchQueue.main.async {
                    self.itemFiveButton.setImage(try? result.get(), for: .normal)
                    self.itemFiveButton.contentMode = .scaleAspectFill
                    self.itemFiveButton.layer.cornerRadius = 20
                    self.itemFiveButton.layer.borderWidth = 3
                    self.itemFiveButton.layer.borderColor = UIColor.black.cgColor
                    self.itemFiveButton.layer.masksToBounds = true
                }
            }
        } else {
            reset(itemFiveButton)
        }
        
        if let itemSix = build.itemSix {
            ItemController.fethItemImage(items: itemSix) { result in
                DispatchQueue.main.async {
                    self.itemSixButton.setImage(try? result.get(), for: .normal)
                    self.itemSixButton.contentMode = .scaleAspectFill
                    self.itemSixButton.layer.cornerRadius = 20
                    self.itemSixButton.layer.borderWidth = 3
                    self.itemSixButton.layer.borderColor = UIColor.black.cgColor
                    self.itemSixButton.layer.masksToBounds = true
                }
            }
        } else {
          reset(itemSixButton)
        }
        
        if let championImage = build.championButton {
            ChampionController.fetchImageFor(championInfo: championImage) { result in
                DispatchQueue.main.async {
                    self.championButton.setImage(try? result.get(), for: .normal)
                    self.championButton.contentMode = .scaleAspectFill
                    self.championButton.layer.cornerRadius = 20
                    self.championButton.layer.borderColor = UIColor.black.cgColor
                    self.championButton.layer.borderWidth = 3
                    self.championButton.layer.masksToBounds = true
                }
            }
        } else {
            championButton.setImage(UIImage(systemName: "person"), for: .normal)
            championButton.imageView?.contentMode = .scaleAspectFill


        }
        
        
        
        nameLabel.text = build.title
    }//end of func
    
    func reset(_ button: UIButton) {
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        button.layer.borderColor = UIColor.clear.cgColor
    }//End of func
}//End of class
