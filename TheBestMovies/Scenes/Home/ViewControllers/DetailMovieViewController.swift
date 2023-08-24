//
//  DetailMovieViewController.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import UIKit
import SDWebImage

class DetailMovieViewController: UIViewController {
    // MARK: - Properties
    var viewModel: HomeViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    var movie: Movie?
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overViewTextView.text = ""
        self.getDetailOfMovie()
    }
    
    func getDetailOfMovie() {
        if let movie = movie {
            self.viewModel.getDetailOfMovie(movieId: movie.id)
        }
    }
    
    func setupWith(_ movie: DetailMovie) {
        self.movieNameLabel.text = movie.title
        self.movieYearLabel.text = movie.releaseDate.getYearFromDate()
        if let url = URL(string: movie.getPosterImageUrl()) {
            self.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.posterImageView.sd_setImage(with: url)
            self.posterImageView.contentMode = .scaleAspectFit
        }
        self.overViewTextView.text = movie.overview
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.viewModel.back()
    }
    
}
// MARK: - HomeViewModelViewDelegate
extension DetailMovieViewController: HomeViewModelViewDelegate {
    func succes() {
        DispatchQueue.main.async {
            if let movie = self.viewModel.getCurrentDetailMovie() {
                self.setupWith(movie)
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            self.displayAlert(errorTitle: "", error: "erreur_system".localized())
        }
    }
}
