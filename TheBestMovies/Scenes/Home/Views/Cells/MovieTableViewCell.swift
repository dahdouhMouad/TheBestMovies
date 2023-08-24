//
//  MovieTableViewCell.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(_ movie: Movie) {
        self.nameLabel.text = movie.title
        self.yearLabel.text = movie.releaseDate.getYearFromDate()
        if let url = URL(string: getPosterImageUrl(movie: movie)) {
            self.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.posterImageView.sd_setImage(with: url)
            self.posterImageView.contentMode = .scaleAspectFit
        }
    }
    
    //Helper
    func getPosterImageUrl(movie: Movie) -> String {
        return "https://image.tmdb.org/t/p/w500/" + movie.posterPath
    }
    
}
 
//Documentation
/*
 Example of Images
 https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg
 https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png
 https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png
 */

