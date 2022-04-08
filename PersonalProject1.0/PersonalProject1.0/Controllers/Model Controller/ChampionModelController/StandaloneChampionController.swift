////
////  StandaloneChampionController.swift
////  PersonalProject1.0
////
////  Created by Delstun McCray on 2/10/22.
////
//
//import Foundation
//import UIKit
//
//class StandaloneChampionController {
//    
//    static let cache = NSCache<NSString, UIImage>()
//    
//    static var baseURL = "http://ddragon.leagueoflegends.com/cdn/12.3.1/data/en_US/champion/Azir.json"
//    
//    static func fetchChampio(championID: String, completion: @escaping (Result<StandaloneChampionController, ChampionError>) -> Void) {
//        
//        guard let baseURL = URL(string: baseURL) else { return completion(.failure(.invalidURL)) }
//        
//        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//        let apiQuerey = URLQueryItem(name: "champion", value: championID)
//        components?.queryItems = [apiQuerey]
//        
//        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
//        print(finalURL)
//        
//        URLSession.shared.dataTask(with: finalURL) { data, response, error in
//            if let error = error {
//                return completion(.failure(.throwError(error)))
//                
//            }
//            
//            if let response = response as? HTTPURLResponse {
//                if response.statusCode != 200 {
//                    print("STATUS CODE: \(response.statusCode)")
//                
//                }
//            }
//            
//            guard let data = data else { return completion(.failure(.noData)) }
//            
//            do {
//                let standAloneChampion = try JSONDecoder() .decode(StandAloneTopLevelObject.self, from: data)
//                return completion(.success(standAloneChampion))
//            } catch {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                return completion(.failure(.throwError(error)))
//            }
//            
//        }.resume()
//        
//    }//End of func
//}
