//
//  ChampionCellTableViewCell.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 10/11/21.
//

import UIKit

class ChampionCellTableViewCell: UITableViewCell {

    @IBOutlet weak var championStatsLabel: UILabel!
    
    var stats: ChampionStatsArray? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let stats = stats else { return }
        
        championStatsLabel.text = stats.labelOne
        
        
    }
    
}
