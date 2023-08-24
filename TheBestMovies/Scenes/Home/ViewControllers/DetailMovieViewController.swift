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
        self.setup()
    }
    
    func setup() {
        //just for test
        if let movie = self.movie {
            self.movieNameLabel.text = movie.title
            self.movieYearLabel.text = movie.releaseDate.getYearFromDate()
            if let url = URL(string: getPosterImageUrl(movie: movie)) {
                self.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.posterImageView.sd_setImage(with: url)
                self.posterImageView.contentMode = .scaleAspectFit
            }
            self.overViewTextView.text = movie.overview
        }
    }
    
    //Helper
    func getPosterImageUrl(movie: Movie) -> String {
        return "https://image.tmdb.org/t/p/original/" + movie.posterPath
    }

    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.viewModel.back()
    }
    
}
// MARK: - HomeViewModelViewDelegate
extension DetailMovieViewController: HomeViewModelViewDelegate {
    func succes() {
        DispatchQueue.main.async {
            
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            print("failure")
        }
    }
}
