//
//  ChampionSelectionViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 2/8/22.
//

import UIKit

protocol ChampionSelectionViewControllerDelegate: AnyObject {
    func championSelected(champion: ChampionInfo, button: Int?, build: Build)
}

class ChampionSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet var championSearchBar: UISearchBar!
    @IBOutlet var championCollectionView: UICollectionView!
    
    //MARK: - Properties
    weak var delegate: ChampionSelectionViewControllerDelegate?
    var champions: [ChampionInfo] = []
    var allChampions: [ChampionInfo] = []
    var isModallyPresented = false
    var button: Int?
    var cell: BuildsTableViewCell?
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllChampions()
        updateViews()
        championCollectionView.delegate = self
        championCollectionView.dataSource = self
        championSearchBar.delegate = self
        championCollectionView.keyboardDismissMode = .onDrag
    }//End of func
    
    //MARK: - Helper Funcs
    func updateViews() {
        championCollectionView.reloadData()
    }//End of func
    
    
    func fetchAllChampions() {
        
        ChampionController.fetchChampions { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let champion):
                    self.champions = champion
                    self.allChampions = champion
                    self.updateViews()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "championViewCell", for: indexPath) as? ChampionSelectionCollectionViewCell else { return UICollectionViewCell() }
        
        let champions = champions[indexPath.row]
        
        cell.champions = champions
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isModallyPresented {
            guard let build = cell?.build,
                  let button = button else { return }

            guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ChampionSelectionCollectionViewCell,
                  let _ = selectedCell.championImageView.image else { return }
            
            let champion = champions[indexPath.row]
            self.dismiss(animated: true)
            delegate?.championSelected(champion: champion, button: button, build: build)
        }
    }//End of func
 
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isModallyPresented == false
        
    }
}

//MARK: - Extensions

extension ChampionSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let oneCellWidth = view.frame.width * 0.45
        
        let cellsTotalWidth = oneCellWidth * 2
        
        let leftOverWidth = view.frame.width - cellsTotalWidth
        
        let inset = leftOverWidth / 3
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }//End of func
    
}//End of extension

extension ChampionSelectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.champions = allChampions
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            self.championCollectionView.reloadData()
            return }
        
        let filteredChampions = champions.filter {
            
            $0.name.localizedCaseInsensitiveContains(searchTerm)
            
        }
        
        self.champions = filteredChampions
        self.championCollectionView.reloadData()
        
    }//End of func
}//End of extension
