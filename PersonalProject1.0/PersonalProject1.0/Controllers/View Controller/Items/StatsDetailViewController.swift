//
//  StatsDetailViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/2/21.
//

import UIKit

class StatsDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPlainText: UILabel!
    @IBOutlet weak var baseGoldLabel: UILabel!
    @IBOutlet weak var totalGoldLabel: UILabel!
    @IBOutlet weak var sellingPriceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    //MARK: - Properties
    var item: Items?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
     //   colorGradient()

    }//end of func
    
    //MARK: - Helper funcs
    func updateViews() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        view.insertSubview(blurEffectView, at: 0)
        guard let item = item else { return }
        
        let underlineAttriString = NSAttributedString(string: item.name,
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        itemNameLabel.attributedText = underlineAttriString
        
        itemPlainText.text = item.plaintext
        baseGoldLabel.text = "\(item.gold.base)"
        totalGoldLabel.text = "\(item.gold.total)"
        sellingPriceLabel.text = "\(item.gold.sell)"
    
        
        ItemController.fethItemImage(items: item) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let full):
                    self.itemImageView.image = full
                case .failure(_):
                    self.itemImageView.image = UIImage(systemName: "square")
                }
            }
        }
    }
    
    func colorGradient() {

        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.view.bounds

        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]

        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
}
