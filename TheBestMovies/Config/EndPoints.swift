//
//  EndPoints.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation

enum Endpoints {
    
    static let baseURL = "https://api.themoviedb.org"
    
    case trendingMovies

    var fullPath: String {
        let path: String
        
        switch self {
        case .trendingMovies:
            path = "/3/discover/movie"
        }
        
        return Endpoints.baseURL + path + "?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"
    }
}


