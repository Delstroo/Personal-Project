//
//  BuildModels.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 9/9/21.
//

import UIKit

class BuildController {
    
    //SOT
    var builds: [Build] = []
    
    //Properties
    static let buildInstance = BuildController()
    
    
    //fetch build
    
    
    func createBuild(title: String) {
        
        let newBuild = Build(title: title)
        builds.append(newBuild)
        saveToPersistenceStore()
        //return newBuild
    }
    
    //update build
    func updateBuild(build: Build) {
        saveToPersistenceStore()
        print("updateBuild")
    }
    
    //delete build
    func deleteBuild(build: Build) {
        
        guard let index = builds.firstIndex(of: build) else { return }
        
        builds.remove(at: index)
        
        saveToPersistenceStore()
    }
    
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Builds.json")
        return fileURL
        
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(builds)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            
        }
    }
    
    func loadFroPersistenceStore() {
        do {
            
            let data = try Data(contentsOf: createPersistenceStore())
            builds = try JSONDecoder().decode([Build].self, from: data)
            print(builds.count)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        
    }
    
}
