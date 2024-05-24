//
//  MovieCell.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import UIKit

class MovieCell: UITableViewCell {
 
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieAuthorLabel: UILabel!
    @IBOutlet weak var moviePlotLabel: UILabel!
    
    private var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImageView.image = nil
        self.movieTitleLabel.text = ""
        self.movieAuthorLabel.text = ""
        self.moviePlotLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated) 
    }
    
    func initMovieCell(movie: Movie) {
        self.movie = movie
        movieImageView.downloaded(from: movie.poster!)
        movieTitleLabel.text = movie.title
        movieAuthorLabel.text = movie.year
        moviePlotLabel.text = movie.plot
    }
    
    func initMovieCell(poster: URL, title: String, author: String, plot: String) {
        if let poster = URL(string: poster.absoluteString) {
            movieImageView.downloaded(from: poster)
            movieTitleLabel.text = title
            movieAuthorLabel.text = author
            moviePlotLabel.text = plot
        } else {
            movieImageView.image = UIImage(named: "movie")
            movieTitleLabel.text = title
            movieAuthorLabel.text = author
            moviePlotLabel.text = plot
        }
    }
}
