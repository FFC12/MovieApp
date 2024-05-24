//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

class HomeViewModel {
    private var pageNumber: Int = 1
    private var pageCount: Int = 0
    
    // default keyword
    private var keyword: String = "var"

    init() {
    }
    
    private func nextMovies(completion: @escaping (([MovieSearchResult])->Void)) {
        Common.shared.getMovies(search: keyword, at: pageNumber) { (movies, total) in
            self.pageCount = total / 10
            completion(movies)
        }
    }
    
    func next(completion: @escaping (([MovieSearchResult]) -> Void)) {
        self.nextMovies {
            completion($0)
        }
    }
    
    func loadMore(completion: @escaping (([MovieSearchResult])->Void)) {
        if self.pageNumber <= self.pageCount {
            self.pageNumber += 1
            self.nextMovies {
                completion($0)
            }
        } else {
            completion([])
        }
    }
    
    func getMovieId(_ id: String, completion: @escaping (Movie?) -> Void) {
        Common.shared.getMovieById(id: id) { movie in
            completion(movie)
        }
    }
    
    func addFavourite(id: String, url: String, title: String) {
        Common.shared.addMovieToFavourite(url: url, title: title, id: id)
    }
    
    func addWatched(id: String, url: String, title: String) {
        Common.shared.setMovieAsWatched(url: url, title: title, id: id)
    }
    
    func getFavouriteMovies() -> [Any]? {
        return Common.shared.getFavouriteMovies()
    }
    
    func getWatchedMovies() -> [Any]? {
        return Common.shared.getWatchedMovies()
    }
}
