//
//  ViewControllerTest.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 2/10/22.
//

import UIKit

class ViewControllerTest: UIViewController {

    @IBOutlet var randomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func randomButtonTapped(_ sender: Any) {
        let randomInt = Int.random(in: 0..<200)
    }//End of func
    
    func updateViews() {
        randomLabel.text = "\(randomButtonTapped((Any).self))"
    }
}
