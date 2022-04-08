//
//  ChampionErrors.swift
//  PersonalProject1.0
//
//  Created by Delstun McCray on 8/22/21.
//

import Foundation

enum ChampionError: LocalizedError {
    
    case invalidURL
    case throwError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "There was a failure with the server."
        case .throwError(_):
            return "there was an error with our network call."
        case .noData:
            return "There was no data found."
        case .unableToDecode:
            return "there was no data found."
        }
    }
}//end of enum
