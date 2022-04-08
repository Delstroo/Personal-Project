//
//  ItemsCollectionViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import UIKit
import AVFoundation

protocol ItemCollectionViewControllerDelegate: AnyObject {
    func itemIsSelected(item: Items, button: Int, build: Build)
    
}

private let reuseIdentifier = "itemViewCell"

class ItemsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    //MARK: - Properties
    weak var delegate: ItemCollectionViewControllerDelegate?
    var items: [Items] = []
    var allItems: [Items] = []
    var isModallyPresented = false
    var button: Int?
    var cell: BuildsTableViewCell?
    var audioPlayer:AVPlayer!
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        updateViews()
     //   colorGradient()
   //     playBuildSound()
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemSearchBar.delegate = self
        itemCollectionView.keyboardDismissMode = .onDrag

        
    }//end of func
    
    //MARK: - Helper funcs
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .dark {
                    
                }
                else {
                    //Light
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func updateViews() {
        itemCollectionView.reloadData()
        
    }//end of func
    
    func playBuildSound() {
        
        let url = Bundle.main.url(forResource:"lol_pm_receive", withExtension: "mp3")
        
        audioPlayer = AVPlayer.init(url: url!)
        
        audioPlayer.play()
    }
    
    func fetchAllItems() {
        
        ItemController.fetchItems { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.items = items
                    self.allItems = items
                    self.updateViews()
                    print(items)
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }//end of func
    
//    func colorGradient() {
//
//
//        let gradientCollection = CAGradientLayer()
//
//        gradientCollection.frame = self.itemCollectionView.bounds
//
//        gradientCollection.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]
//        self.itemCollectionView.backgroundView = UIView.init(frame: self.view.bounds)
//
//        self.itemCollectionView.backgroundView?.layer.insertSublayer(gradientCollection, at: 0)
//
//    }//End of func
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemViewCell", for: indexPath) as? ItemsCollectionViewCell else {return UICollectionViewCell() }
        
        let items = items[indexPath.row]
        
        cell.items = items
//        cell.layer.cornerRadius = 1/2
//        cell.layer.borderWidth = 0
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        cell.layer.shadowRadius = 50.0
//        cell.layer.shadowOpacity = 1
//        cell.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isModallyPresented {
            
            guard let button = button,
                  let build = cell?.build else { return }
                  
            guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ItemsCollectionViewCell,
                  let _ = selectedCell.itemImageView.image else { return }
           
            let item = items[indexPath.row]
            self.dismiss(animated: true)
            delegate?.itemIsSelected(item: item, button: button, build: build)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemVC" {
            
            guard let cell = sender as? ItemsCollectionViewCell,
                  let indexPath = itemCollectionView.indexPath(for: cell),
                  let destination = segue.destination as? StatsDetailViewController else { return }
            let selectedItem = items[indexPath.row]
            destination.item = selectedItem
            
        }
    }//end of func
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isModallyPresented == false
        
    }
}//end of class

//MARK: - Extensions

extension ItemsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let oneCellWidth = view.frame.width * 0.45
        
        let cellsTotalWidth = oneCellWidth * 2
        
        let leftOverWidth = view.frame.width - cellsTotalWidth
        
        let inset = leftOverWidth / 3
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
    
}

extension ItemsCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.items = allItems
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            self.itemCollectionView.reloadData()
            return }
        
        let filteredItems = items.filter {
            
            $0.name.localizedCaseInsensitiveContains(searchTerm)
        }
        
        self.items = filteredItems
        self.itemCollectionView.reloadData()
        
    }
    
}



