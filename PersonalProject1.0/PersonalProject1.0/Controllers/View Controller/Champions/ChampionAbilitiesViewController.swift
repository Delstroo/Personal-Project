//
//  ChampionAbilitiesViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 2/11/22.
//

import UIKit

class ChampionAbilitiesViewController: UIViewController {
    
    //MARK: - Q
    @IBOutlet var qNameLabel: UILabel!
    @IBOutlet var qDescriptionLabel: UILabel!
    @IBOutlet var QLabel: UILabel!
    @IBOutlet var qUIImage: UIImageView!
    
    //MARK: - W
    @IBOutlet var wLabel: UILabel!
    @IBOutlet var wNamelabel: UILabel!
    @IBOutlet var wDescription: UILabel!
    @IBOutlet var wUIImage: UIImageView!
    
    //MARK: - E
    @IBOutlet var eLabel: UILabel!
    @IBOutlet var eNameLabel: UILabel!
    @IBOutlet var eDescriptionLabel: UILabel!
    @IBOutlet var eUIImage: UIImageView!
    
    //MARK: - R
    @IBOutlet var rLabel: UILabel!
    @IBOutlet var rNameLabel: UILabel!
    @IBOutlet var rDescriptionLabel: UILabel!
    @IBOutlet var rUIImage: UIImageView!
    
    //MARK: - Ally Tips
    @IBOutlet var allyTipsLabel: UILabel!
    @IBOutlet var tipsLabel: UILabel!
    
    //MARK: - Enemy Tips
    @IBOutlet var enemyTipsLabel: UILabel!
    @IBOutlet var enemyLabel: UILabel!
    
    
    var champion: ChampionData?
    var spellList: [Spells] = []
    var spells: Spells?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        view.backgroundColor = UIColor.clear
    }
    
    func updateViews() {
        guard let champion = champion else { return }
        
        //MARK: - Q
        qNameLabel.text = champion.spells[0].name
        qDescriptionLabel.text = champion.spells[0].description
        QLabel.underline()
        qNameLabel.underline()
        
        //MARK: - W
        wNamelabel.text = champion.spells[1].name
        wDescription.text = champion.spells[1].description
        wLabel.underline()
        wNamelabel.underline()
        //MARK: - E
        eNameLabel.text = champion.spells[2].name
        eDescriptionLabel.text = champion.spells[2].description
        eLabel.underline()
        eNameLabel.underline()
        
        //MARK: - R
        rNameLabel.text = champion.spells[3].name
        rDescriptionLabel.text = champion.spells[3].description
        rLabel.underline()
        rNameLabel.underline()
        
        //MARK: - Ally
        //        allyTipsLabel.text = championData.allytips.joined(separator: "\n\n")
        allyTipsLabel.underline()
        tipsLabel.text = champion.allytips.joined(separator: "\n\n")
        
        //MARK: - Enemy
        enemyTipsLabel.underline()
        enemyLabel.text = champion.enemytips.joined(separator: "\n\n")
        
        //MARK: - Blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        view.insertSubview(blurEffectView, at: 0)
        
        //MARK: - Q Images
        
        ChampionController.fetchImageForSpell(spell: champion.spells[0].image.full) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let spell):
                    self.qUIImage.image = spell
                    self.qUIImage.layer.cornerRadius = 15
                case .failure(let errror):
                    print("Error in \(#function) : \(errror.localizedDescription) \n---\n \(errror)")
                }
            }
        }//End of func
        
        //MARK: - Q Images
        
        ChampionController.fetchImageForSpell(spell: champion.spells[1].image.full) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let spell):
                    self.wUIImage.image = spell
                    self.wUIImage.layer.cornerRadius = 15
                case .failure(let errror):
                    print("Error in \(#function) : \(errror.localizedDescription) \n---\n \(errror)")
                }
            }
            
            //MARK: - Q Images
            
            ChampionController.fetchImageForSpell(spell: champion.spells[2].image.full) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let spell):
                        self.eUIImage.image = spell
                        self.eUIImage.layer.cornerRadius = 15
                    case .failure(let errror):
                        print("Error in \(#function) : \(errror.localizedDescription) \n---\n \(errror)")
                    }
                }
                
                //MARK: - Q Images
                
                ChampionController.fetchImageForSpell(spell: champion.spells[3].image.full) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let spell):
                            self.rUIImage.image = spell
                            self.rUIImage.layer.cornerRadius = 15
                        case .failure(let errror):
                            print("Error in \(#function) : \(errror.localizedDescription) \n---\n \(errror)")
                        }
                    }
                }
            }//End of func
        }//End of class
    }
}
