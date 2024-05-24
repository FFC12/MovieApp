//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImageView.image = UIImage(named: "popcorn.fill")
        self.movieNameLabel.text = "N/A"
    }
    
    func initCell(url: String, name: String) {
        self.movieImageView.downloaded(from: url)
        self.movieNameLabel.text = name
    }
}
