//
//  HomeApiService.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation

protocol HomeService {
    func getMoviesList(completion: @escaping (MoviesData?, String?) -> Void)
}

class HomeApiService {

    let apiClient: ApiClient

    // MARK: - Init
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

}

extension HomeApiService: HomeService {
    func getMoviesList(completion: @escaping (MoviesData?, String?) -> Void) {
        self.apiClient.GET(Endpoints.trendingMovies.fullPath) { (result: Result<MoviesData, APIError>) in
            switch result {
                case .success(let response):
                    completion(response, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
            
}

