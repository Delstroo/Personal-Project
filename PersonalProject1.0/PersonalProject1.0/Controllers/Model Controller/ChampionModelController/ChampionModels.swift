//
//  ChampionModels.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import Foundation
import UIKit

class ChampionController {
    
    static let cache = NSCache<NSString, UIImage>()
//http://ddragon.leagueoflegends.com/cdn/12.3.1/data/en_US/champion/Azir.json
    static var baseURL = "https://ddragon.leagueoflegends.com/cdn/11.16.1/data/en_US/champion"
    
    
    //static let apiKey = "RGAPI-76996e5f-ed0d-4366-9f5b-bdf440691138"
    
    static func fetchChampions(completion: @escaping (Result<[ChampionInfo], ChampionError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidURL))}
        
        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        guard let finalURL = components?.url?.appendingPathExtension("json") else { return completion(.failure(.invalidURL))}
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
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let champions = topLevelObject.data
                
                var arrayOfChampions: [ChampionInfo] = []
                for champion in champions.values {
                    arrayOfChampions.append(champion)
                }
                arrayOfChampions.sort { $0.name < $1.name }
                
                return completion(.success(arrayOfChampions))
                

            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.throwError(error)))
            }
        }.resume()
    }//End of func
    
    static func fetchStandAloneChampion(championName: String, completion: @escaping(Result<ChampionData, ChampionError>) -> Void) {
        
        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidURL)) }
        
        let championNameURL = baseURL.appendingPathComponent(championName)
        
        let finalURL = championNameURL.appendingPathExtension("json")
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.throwError(error)))
                
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("STATUS CODE: \(response.statusCode)")
                    
                }
                
            }//End of If
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(StandAloneTopLevelObject.self, from: data)
                return completion(.success(topLevelObject.data.values.first!))

            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.throwError(error)))
            }
            
        }.resume()
        
    }//End of func
    
    static func fetchImageForSpell(spell: String, completion: @escaping(Result<UIImage, ChampionError>) -> Void) {

            guard let baseURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/12.3.1/img/spell/") else { return completion(.failure(.invalidURL)) }
            
        let finalURL = baseURL.appendingPathComponent(spell)
            
            print(finalURL)
            
            URLSession.shared.dataTask(with: finalURL) { data, _, error in
                
                if let error = error {
                    return completion(.failure(.throwError(error)))
                    
                }
                
                guard let data = data else { return completion(.failure(.noData)) }
                
                guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
                completion(.success(image))
            }.resume()
        }
    
    static func fetchImageFor(championInfo: ChampionInfo, completion: @escaping(Result<UIImage, ChampionError>) -> Void) {
        
        guard let baseURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/11.16.1/img/champion/") else { return completion(.failure(.invalidURL)) }
        
        let finalURL = baseURL.appendingPathComponent(championInfo.image.full)
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                return completion(.failure(.throwError(error)))
                
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(image))
        }.resume()
    }
}
