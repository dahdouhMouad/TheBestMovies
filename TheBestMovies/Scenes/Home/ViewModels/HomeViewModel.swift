//
//  HomeViewModel.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation
import UIKit

protocol HomeViewModelType {
    var viewDelegate: HomeViewModelViewDelegate? { get set }

    //Networking
    func getHome()
    
    //Data Source
    func getMoviesCount() -> Int
    func itemFor(row: Int) -> Movie
    
    //Routing
    func didSelectMovieWith(row: Int)
    func back()
}

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func goToDetailOfThis(_ movie: Movie)
    func back()
}

protocol HomeViewModelViewDelegate: AnyObject {
    func succes()
    func failure()
}


class HomeViewModel {

    // MARK: - Delegates
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?

    // MARK: - Properties
    fileprivate let service: HomeService
    var movies: [Movie] = []
    
    // MARK: - Init
    init(service: HomeService) {
        self.service = service
    }

    func start() {
        
    }
    
}


extension HomeViewModel: HomeViewModelType {
    
    func getHome() {
        self.service.getMoviesList() { [weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                self.viewDelegate?.failure()
            } else {
                self.movies = data?.movies ?? []
                self.viewDelegate?.succes()
            }
        }
    }
    
    //Data Source 
    func getMoviesCount() -> Int {
        return self.movies.count
    }
    
    func itemFor(row: Int) -> Movie {
        return self.movies[row]
    }
    
    //Routing
    func back() {
        self.coordinatorDelegate?.back()
    }
    
    func didSelectMovieWith(row: Int) {
        let movie = itemFor(row: row)
        dump(movie)
        self.coordinatorDelegate?.goToDetailOfThis(movie)
    }
}
