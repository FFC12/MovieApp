//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

class MovieDetailsViewModel {

    func getMovieDetails(id: String, completion: @escaping (Movie?) -> Void) {
        Common.shared.getMovieById(id: id) { movie in
            completion(movie)
        }
    }
}
