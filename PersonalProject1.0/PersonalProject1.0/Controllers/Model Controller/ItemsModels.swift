//
//  ItemsModels.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import Foundation
import UIKit



class ItemController {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static var baseURL = "https://ddragon.leagueoflegends.com/cdn/11.17.1/data/en_US/item.json"
    
    static func fetchItems(completion: @escaping (Result<[Items], ChampionError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidURL)) }
        
        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.throwError(error)))
                
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("STATUS CODE: \(response.statusCode)")
                    
                }
                
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TheTopLevelObject.self, from: data)
                let items = topLevelObject.data
                
                var arrayOfItems: [Items] = []
                for items in items.values {
                    arrayOfItems.append(items)
                }
                arrayOfItems.sort { $0.name < $1.name }
                
                return completion(.success(arrayOfItems))
                

            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.throwError(error)))
            }
        }.resume()
        
    }//end of func
    
    static func fethItemImage(items: Items, completion: @escaping (Result<UIImage, ChampionError>) -> Void) {
        
        guard let baseURL = URL(string:"https://ddragon.leagueoflegends.com/cdn/11.17.1/img/item/") else { return completion(.failure(.invalidURL)) }
        
        let finalURL = baseURL.appendingPathComponent(items.image.full)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                return completion(.failure(.throwError(error)))
                
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(image))
        }.resume()
        
    }//end of func
    
}//end of class
//

