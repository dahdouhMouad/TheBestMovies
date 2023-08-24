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
        if let url = URL(string: movie.getPosterImageUrl()) {
            self.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.posterImageView.sd_setImage(with: url)
            self.posterImageView.contentMode = .scaleAspectFit
        }
    }
}


