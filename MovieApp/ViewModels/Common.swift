//
//  Common.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

class Common {
    static let shared = Common()
    private let storageLayer = UserLocalStorageService()
    private let networkLayer = GenericNetworkService()
    
    func getMovies(search s: String, at page: Int, completion: @escaping ([MovieSearchResult], Int) -> Void) {
        let req = MovieRetrieveRequest(queryParameters: [
            "s": s,
            "page": String(page)
        ])
        
        self.networkLayer.fetchData(request: req) {
            (result: Result<MovieResponse, NetworkError>) in
            switch result {
            case .success(let movie):
                completion(movie.search, Int(movie.totalResults) ?? 0)
            case .failure(let error):
                print("Error: \(error)")
                completion([], 0)
            }
        }
    }
    
    func getMovieById(id: String, completion: @escaping (Movie?) -> Void) {
        let req = MovieRetrieveRequest(queryParameters: [
            "i": id
        ])
        
        self.networkLayer.fetchData(request: req) {
            (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    func addMovieToFavourite(url: String, title: String, id: String) { 
        storageLayer.save(key: "favourite", value: [
            "url": url,
            "title": title,
            "id": id
        ])
    }
    
    func setMovieAsWatched(url: String, title: String, id: String) {
        storageLayer.save(key: "watched", value: [
            "url": url,
            "title": title,
            "id": id
        ])
    }
    
    func getFavouriteMovies() -> [Any]? {
        return storageLayer.get(key: "favourite")
    }
    
    func getWatchedMovies() -> [Any]? {
        return storageLayer.get(key: "watched")
    } 
}
