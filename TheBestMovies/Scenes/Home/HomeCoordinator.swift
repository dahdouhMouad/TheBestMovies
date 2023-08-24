//
//  HomeCoordinator.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import UIKit

class HomeCoordinator: Coordinator {
    var rootViewController: UINavigationController
    let apiClient: ApiClient
    
    // MARK: VM / VC's
    lazy var homeViewModel: HomeViewModel! = {
        let homeService = HomeApiService(apiClient: apiClient)
        let viewModel = HomeViewModel(service: homeService)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()

    
    // MARK: - Coordinator
    init(rootViewController: UINavigationController, apiClient: ApiClient) {
        self.rootViewController = rootViewController
        self.apiClient = apiClient
    }
    
    override func start() {
        let moviesListVC = UIStoryboard.instantiate(MoviesListViewController.self, from: "Home")
        moviesListVC.viewModel = self.homeViewModel
        self.rootViewController.setViewControllers([moviesListVC], animated: false)
    }
    
     override func finish() {
        
    }
    
}


extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func goToDetailOfThis(_ movie: Movie) {
        let detailMovieVC = UIStoryboard.instantiate(DetailMovieViewController.self, from: "Home")
        detailMovieVC.viewModel = self.homeViewModel
        detailMovieVC.movie = movie
        self.rootViewController.pushViewController(detailMovieVC, animated: true)
    }
    
    func back() {
        self.rootViewController.popViewController(animated: true)
    }
    
}

