//
//  ChampionStatsViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/1/21.
//

import UIKit

class ChampionStatsViewController: UIViewController {
    
//MARK: - Properties
    var stats: ChampionStats?
    var champion: ChampionInfo? {
        didSet {
            self.stats = self.champion?.stats
            
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var hpPerLevelLabel: UILabel!
    @IBOutlet weak var hpRegenLabel: UILabel!
    @IBOutlet weak var hpRegenPerLevelLabel: UILabel!
    @IBOutlet weak var magicPenLabel: UILabel!
    @IBOutlet weak var mpPerLevelLabel: UILabel!
    @IBOutlet weak var movementSpeedLabel: UILabel!
    @IBOutlet weak var armourLabel: UILabel!
    @IBOutlet weak var armourPerLevelLabel: UILabel!
    @IBOutlet weak var spellBlockLabel: UILabel!
    @IBOutlet weak var spellBlockPerLevelLabel: UILabel!
    @IBOutlet weak var attackRangePerLevel: UILabel!
    @IBOutlet weak var mpRegenLabel: UILabel!
    @IBOutlet weak var mpRegenPerLevelLabel: UILabel!
    @IBOutlet weak var critChanceLabel: UILabel!
    @IBOutlet weak var critChancePerLevelLabel: UILabel!
    @IBOutlet weak var attackDamageLabel: UILabel!
    @IBOutlet weak var attackDamagePerLevelLabel: UILabel!
    @IBOutlet weak var attackSpeedLabel: UILabel!
    @IBOutlet weak var attackSpeedPerLevelLabel: UILabel!
    
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        guard stats != nil else { return }
//       setBlurView()
        updateViews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK: - Helper funcs
    func updateViews() {
        guard let stats = stats else { return }
        
        hpLabel.text = "\(stats.hp)"
        hpPerLevelLabel.text = "\(stats.hpperlevel)"
        magicPenLabel.text = "\(stats.mp)"
        mpPerLevelLabel.text = "\(stats.mpperlevel)"
        movementSpeedLabel.text = "\(stats.movespeed)"
        armourLabel.text = "\(stats.armor)"
        armourPerLevelLabel.text = "\(stats.armorperlevel)"
        spellBlockLabel.text = "\(stats.spellblock)"
        spellBlockPerLevelLabel.text = "\(stats.spellblockperlevel)"
        attackRangePerLevel.text = "\(stats.attackrange)"
        hpRegenLabel.text = "\(stats.hpregen)"
        hpRegenPerLevelLabel.text = "\(stats.hpregenperlevel)"
        critChanceLabel.text = "\(stats.crit)"
        critChancePerLevelLabel.text = "\(stats.critperlevel)"
        attackDamageLabel.text = "\(stats.attackdamage)"
        attackDamagePerLevelLabel.text = "\(stats.attackdamageperlevel)"
        attackSpeedLabel.text = "\(stats.attackspeed)"
        attackSpeedPerLevelLabel.text = "\(stats.attackspeedperlevel)"
        mpRegenLabel.text = "\(stats.mpregen)"
        mpRegenPerLevelLabel.text = "\(stats.mpregenperlevel)"
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        view.insertSubview(blurEffectView, at: 0)
        
        
    }//End of func
    
//    func setBlurView() {
//        // Init a UIVisualEffectView which going to do the blur for us
//        let blurView = UIVisualEffectView()
//        // Make its frame equal the main view frame so that every pixel is under blurred
//        blurView.frame = view.frame
//        // Choose the style of the blur effect to regular.
//        // You can choose dark, light, or extraLight if you wants
//        blurView.effect = UIBlurEffect(style: .regular)
//        // Now add the blur view to the main view
//        view.addSubview(blurView)
//    }
    
    func colorGradient() {

        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.view.bounds

        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]

        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }//End of func
}//End of class
