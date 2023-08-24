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
    func getDetailOfMovie(movieId: Int)
    
    //Data Source
    func getMoviesCount() -> Int
    func itemFor(row: Int) -> Movie
    func getCurrentDetailMovie() -> DetailMovie? 
    
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
    var currentDetailMovie: DetailMovie? = nil
    
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
    
    func getDetailOfMovie(movieId: Int) {
        self.currentDetailMovie = nil
        self.service.getMovieDetail(movieId: movieId) { [weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                self.viewDelegate?.failure()
            } else {
                self.currentDetailMovie = data
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
    
    func getCurrentDetailMovie() -> DetailMovie? {
        return self.currentDetailMovie
    }
    
    //Routing
    func back() {
        self.coordinatorDelegate?.back()
    }
    
    func didSelectMovieWith(row: Int) {
        let movie = itemFor(row: row)
        self.coordinatorDelegate?.goToDetailOfThis(movie)
    }
}
