//
//  ChampionsTableViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 10/7/21.
//

import UIKit
import AVFoundation

class ChampionsTableViewController: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var championSearchBar: UISearchBar!
    
    //MARK: - Properties
    var champions: [ChampionInfo] = []
    var character: ChampionInfo?
    var standAloneChampion: ChampionData?
    var audioPlayer:AVPlayer!
    var allChampions: [ChampionInfo] = []
    let randomInt = Int.random(in: 0..<200)
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllChampions()
        updateViews()
        handleReselect()
//        colorGradient()
      //  playBuildSound()
        championSearchBar.delegate = self
        championSearchBar.layer.cornerRadius = championSearchBar.frame.height / 2
        tableView.keyboardDismissMode = .onDrag

    }
    
    //MARK: - Helper Functions
    func updateViews() {
        tableView.reloadData()
    print(randomInt)

        
    }//End of func
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        championSearchBar.endEditing(true)

    }
    
    func playBuildSound() {
        
        let url = Bundle.main.url(forResource:"lol_pm_receive", withExtension: "mp3")
        
        audioPlayer = AVPlayer.init(url: url!)
        
        audioPlayer.play()
    }//End of func
    
    func fetchAllChampions() {
        
        ChampionController.fetchChampions() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let champions):
                    self.champions = champions
                    self.allChampions = champions
                    self.updateViews()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }//End of func
    
    func handleReselect() {
           tableView?.setContentOffset(.zero, animated: true)
       }
    
    func colorGradient() {

        
        let gradientCollection = CAGradientLayer()
        
        gradientCollection.frame = self.tableView.bounds
        
        gradientCollection.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]
        self.tableView.backgroundView = UIView.init(frame: self.view.bounds)
        
        self.tableView.backgroundView?.layer.insertSublayer(gradientCollection, at: 0)
        
    }//End of func
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champions.count
    }//End of func
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "championCells", for: indexPath) as? ChampionTableViewCell else { return UITableViewCell() }
        
        let character = champions[indexPath.row]
        
        cell.champions = character
        print(character.key)
        //        cell.addGradientBackground(firstColor: UIColor(#colorLiteral(red: 0.9647, green: 0.702, blue: 0.898, alpha: 1)), secondColor: UIColor(#colorLiteral(red: 0.7843, green: 0.4627, blue: 1, alpha: 1)), thirdColor: UIColor(#colorLiteral(red: 0.4471, green: 0.1961, blue: 0.949, alpha: 1)), fourthColor: UIColor(#colorLiteral(red: 0.1255, green: 0.0667, blue: 0.3569, alpha: 1)), fifthColor: UIColor(#colorLiteral(red: 0.0039, green: 0.0039, blue: 0.0314, alpha: 1)))
        
//        cell.backgroundColor = .clear
//        cell.layer.cornerRadius = cell.frame.height / 4
        
        return cell
    }//End of func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            
            guard let cell = sender as? ChampionTableViewCell,
                  let indexPath = tableView.indexPath(for: cell),
                  let destination = segue.destination as?
                    ChampionDetailsViewController else { return }
            let selectedChampion = champions[indexPath.row]
            destination.champion = selectedChampion
            
        }
    }//end of func
}//End of class

extension ChampionsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.champions = allChampions
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            self.tableView.reloadData()
            return
        }
        
        let filteredChampions = champions.filter {
            
            $0.name.localizedCaseInsensitiveContains(searchTerm)
        }
        
        self.champions = filteredChampions
        self.tableView.reloadData()
    }//End of func
}// End of struct
