//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var movieDetailsViewModel: MovieDetailsViewModel?
    var movieId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        self.movieDetailsViewModel = MovieDetailsViewModel()
        self.initMovie(id: self.movieId!)
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.isHidden = false
    }
 
    private func initMovie(id: String) {
        self.movieDetailsViewModel?.getMovieDetails(id: id) { movie in
            DispatchQueue.main.async {
                self.movieTitleLabel.text = movie?.title ?? "N/A"
                self.yearLabel.text = movie?.year ?? "N/A"
                self.typeLabel.text = movie?.type ?? "N/A"
                self.actorLabel.text = movie?.actors ?? "N/A"
                self.directorLabel.text = movie?.director ?? "N/A"
                self.plotLabel.text = movie?.plot ?? "N/A"
                if movie?.poster != nil {
                    guard let poster = movie?.poster else { return }
                    self.posterImageView.downloaded(from: poster )
                } else {
                    self.posterImageView.image = UIImage(named: "no-image")
                }
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
    }
}
