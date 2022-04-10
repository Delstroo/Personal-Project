//
//  ChampionDetailsViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import UIKit

class ChampionDetailsViewController: UIViewController {
    
    
    //MARK: - Properties
    var champion: ChampionInfo?
    var stats: ChampionStats?
    var stat: [ChampionStatsArray] = []
    var championData: ChampionData?
    var spells: Spells?
    var skin: Skins?
    var skins: [Skins] = []
    var statNameArray: [String?] = []
    var statNumberArray: [String] = []
    
    //MARK: - Outlets
    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurbLabel: UILabel!
    @IBOutlet weak var toStatsButton: UIButton!
    @IBOutlet var allyTipsLabel: UILabel!
    @IBOutlet var loreLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var championAbilitiesButton: UIButton!
    
    //    @IBOutlet weak var blurbLabel: UILabel!
    //    @IBOutlet weak var statsButton: UIButton!
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        championImageView.layer.cornerRadius = championImageView.frame.height / 4.0
        championImageView.layer.borderColor = UIColor.black.cgColor
        championImageView.layer.borderWidth = 3
        fetchChampionData()
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        view.insertSubview(blurEffectView, at: 0)
        view.backgroundColor = UIColor.clear
        fetchChampionSkins()
        
    }//end of func
    
    //MARK: - Action
    @IBAction func statsButtonTapped(_ sender: Any) {
    }
    @IBAction func buttonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "championAbilitiesVC") as? ChampionAbilitiesViewController else { return }
        
        viewController.champion = championData
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        self.present(viewController, animated: true)
    }//End of func
    @IBAction func skinsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "toSkinsVC") as? ChampionSkinSplashCollectionViewController else { return }
        
        viewController.character = championData
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.large()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        self.present(viewController, animated: true)
        
        //toSkinsVC
    }
    
    //MARK: - Helper Funcs
    func updateViews() {
        guard let champions = champion,
              let championData = championData else { return }
        
        let underlineAttriString = NSAttributedString(string: champions.name,
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        nameLabel.attributedText = underlineAttriString
        titleLabel.text = champions.title
        blurbLabel.text = championData.lore
        loreLabel.underline()
        
        
        ChampionController.fetchImageFor(championInfo: champions) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let full):
                    self.championImageView.image = full
                case .failure(_):
                    self.championImageView.image = UIImage(systemName: "Square")
                    
                }
            }
        }
    }//End of func
    
    func fetchChampionData() {
        
        ChampionController.fetchStandAloneChampion(championName: champion?.id ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let champion):
                    self.championData = champion
                    self.updateViews()
                    
                case .failure(let error): break
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }//End of func
    
    func fetchChampionSkins() {
        ChampionController.fetchSkinSplashesFor(championName: champion?.name ?? "", skinNumber: skins.count) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.updateViews()
                    
                case .failure(let error): break
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func colorGradient() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }//End of func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statsVC" {
            
            guard let destination = segue.destination as? ChampionStatsViewController else { return }
            
            let statScreen = champion
            destination.champion = statScreen
            
        }
    }
}//end of class

//MARK: - Extensions
extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor, thirdColor: UIColor, fourthColor: UIColor, fifthColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor, fourthColor.cgColor, fifthColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        print(gradientLayer.frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}//End of extension

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
        
    }
}//End of extension

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
}//End of extension
