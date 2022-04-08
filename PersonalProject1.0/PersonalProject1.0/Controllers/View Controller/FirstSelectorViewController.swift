//
//  ViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import UIKit

class FirstSelectorViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var championButton: UIButton!
    @IBOutlet weak var buildsButton: UIButton!
    @IBOutlet weak var itemButtons: UIButton!
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
       // fetchData()
        updateViews()
        buttonShapeAndColor(championButton)
        buttonShapeAndColor(buildsButton)
        buttonShapeAndColor(itemButtons)

    }//End of func
    
    //MARK: - Helper funcs
    func updateViews() {
        
            let gradientLayer = CAGradientLayer()

            gradientLayer.frame = self.view.bounds

            gradientLayer.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.blue.cgColor, UIColor.cyan.cgColor]


            self.view.layer.insertSublayer(gradientLayer, at: 0)
        }//End of func
    
    //MARK: - Actions
    
    @IBAction func championButtonTapped(_ sender: Any) {
    }
    @IBAction func itemsButtonTapped(_ sender: Any) {
    }
    @IBAction func buildsButtonTapped(_ sender: Any) {
    }
    
    func buttonShapeAndColor(_ button: UIButton) {
        
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.cornerRadius = championButton.frame.height / 8
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 4
    }//End of func
    
}//End of class
