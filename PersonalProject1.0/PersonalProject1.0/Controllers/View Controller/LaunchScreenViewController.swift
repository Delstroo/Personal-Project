//
//  LaunchScreenViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/29/21.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    //MARK: - Properties
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "6674e775d55c4ed6a459813ab958abd4 (2)"))
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
//        colorGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // get rid of the default constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // "drag out" new constraints
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.animate()
    }//End of func
    
    //MARK: - Helper funcs
    func colorGradient() {

        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.view.bounds

        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]

        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }//End of func
    
    private func animate() {
        // spend 1 second animating
        UIView.animate(withDuration: 2, animations: {
            
            // grow the imageview
            self.imageView.transform = CGAffineTransform(scaleX: 3, y: 3)
            
            // hide the imageview
            self.imageView.alpha = 0
            
        }, completion: { _ in
            
            // same as SceneDelegate, replace initial view controller with a new one
            UIApplication.shared.windows.first?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        })
    }//end of func
}
