//
//  MoviesListViewController.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import UIKit

class MoviesListViewController: UIViewController {
    // MARK: - Properties
    var viewModel: HomeViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getHome()
        self.setupTableView()
        
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        self.tableView.register(MovieTableViewCell.self)
    }
 
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension MoviesListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let movie = self.viewModel.itemFor(row: indexPath.row)
        cell.configureWith(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectMovieWith(row: indexPath.row)
    }
    
}

// MARK: - HomeViewModelViewDelegate
extension MoviesListViewController: HomeViewModelViewDelegate {
    func succes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            self.displayAlert(errorTitle: "", error: "erreur_system".localized())
        }
    }
}
