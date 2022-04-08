//
//  BuildsTableViewController.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/3/21.
//

import UIKit
import AVFoundation

class BuildsTableViewController: UITableViewController {
    
    
    var audioPlayer:AVPlayer!
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        BuildController.buildInstance.loadFroPersistenceStore()
        tableView.reloadData()
       // colorGradient()
      //  playBuildSound()
    }
    
    //MARK: - Actions
    @IBAction func addBuildButtonTapped(_ sender: Any) {
//        let build = BuildController.buildInstance.createBuild(title: title ?? "")
        buildAlertController()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BuildController.buildInstance.builds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell", for: indexPath) as? BuildsTableViewCell else { return UITableViewCell() 	}
        
        let build = BuildController.buildInstance.builds[indexPath.row]
        
        cell.build = build
//        cell.backgroundColor = .clear
//        cell.addGradientBackground(firstColor: UIColor(#colorLiteral(red: 0.1294, green: 0.0196, blue: 0.2078, alpha: 1)), secondColor: UIColor(#colorLiteral(red: 0.2627, green: 0.051, blue: 0.2941, alpha: 1)), thirdColor: UIColor(#colorLiteral(red: 0.4824, green: 0.2, blue: 0.4902, alpha: 1)), fourthColor: UIColor(#colorLiteral(red: 0.7843, green: 0.4549, blue: 0.698, alpha: 1)), fifthColor: UIColor(#colorLiteral(red: 0.9608, green: 0.8353, blue: 0.8784, alpha: 1)))
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.delegate = self
        
        return cell
    }
    
    func presentItemCollectionVC(button: Int, cell: BuildsTableViewCell) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewController = storyboard.instantiateViewController(identifier: "ItemCollection") as? ItemsCollectionViewController else { return }
            viewController.modalPresentationStyle = .automatic
            viewController.delegate = self
            viewController.button = button
            viewController.cell = cell
            viewController.isModallyPresented = true
            self.present(viewController, animated: true)
        }
    }//end of func
    
    func presentChampionCollectionVC(button: Int, cell: BuildsTableViewCell) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "championsVC") as? ChampionSelectionViewController else { return }
            viewController.modalPresentationStyle = .automatic
            viewController.delegate = self
            viewController.button = button
            viewController.cell = cell
            viewController.isModallyPresented = true
            self.present(viewController, animated: true)
        }
    }
    
    func playBuildSound() {
        
        let url = Bundle.main.url(forResource:"sound-effects-league-of-legends-sound", withExtension: "mp3")
        
        audioPlayer = AVPlayer.init(url: url!)
        
        audioPlayer.play()
    }
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let build = BuildController.buildInstance.builds[indexPath.row]
            BuildController.buildInstance.deleteBuild(build: build)	
            
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.reloadData()
            
        }
     }
    
    func buildAlertController() {
            
            let alert = UIAlertController(title: "Make a build", message: "Don't be afraid to make a fun build!", preferredStyle: .alert)
            
            alert.addTextField { toDoList in
                toDoList.placeholder = "Build name here..."
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let addAction = UIAlertAction(title: "Add", style: .default) { _ in
                
                guard let assignmentTitle = alert.textFields![0].text else { return }
                
                BuildController.buildInstance.createBuild(title: assignmentTitle)
                self.tableView.reloadData()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(addAction)
            
            present(alert, animated: true)
            
        }
    
    func presentBuildAlertController(for build: Build?) {
        
        let alertController = UIAlertController(title: "Add build name.", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter build name here..."
            textField.autocapitalizationType = .sentences
            textField.autocorrectionType = .no
            textField.text = "Aatrox"
        }
        
        let addAction = UIAlertAction(title: "Send", style: .default) { (_) in
            guard let body = alertController.textFields?.first?.text, !body.isEmpty else { return }
    
            BuildController.buildInstance.createBuild(title: body)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    
    
}//end of class

extension BuildsTableViewController: BuildsTableViewCellDelegate {
    
    func championButtonTapped(button: Int, cell: BuildsTableViewCell) {
        presentChampionCollectionVC(button: button, cell: cell)
    }
    
    func itemButtonTapped(button: Int, cell: BuildsTableViewCell) {
        
        presentItemCollectionVC(button: button, cell: cell)
        
    }
    
}

extension BuildsTableViewController: ItemCollectionViewControllerDelegate {
    func itemIsSelected(item: Items, button: Int, build: Build) {
        switch button {
        case 1:
            build.itemOne = item
        case 2:
            build.itemTwo = item
        case 3:
            build.itemThree = item
        case 4:
            build.itemFour = item
        case 5:
            build.itemFive = item
        case 6:
            build.itemSix = item
            
        default:
            print("Bad button.")
        }
        
        // itemButton.setImage(itemImage, for: .normal)
        tableView.reloadData()
        BuildController.buildInstance.updateBuild(build: build)
    }//end of func

    func colorGradient() {
        
        //let color = #colorLiteral
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.tableView.bounds
         
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]
        
        self.tableView.backgroundView = UIView.init(frame: self.tableView.bounds)
        
        self.tableView.backgroundView?.layer.insertSublayer(gradientLayer, at: 0)
    
    }//End of func

}//End of extension

extension BuildsTableViewController: ChampionSelectionViewControllerDelegate {
    
    
    func championSelected(champion: ChampionInfo, button: Int?, build: Build) {
  
        build.championButton = champion
        BuildController.buildInstance.updateBuild(build: build)
        tableView.reloadData()
    }
}
