//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

class SearchViewModel: HomeViewModel {
    private var pageNumber: Int = 1
    private var pageCount: Int = 0
    
    private func nextMovies(keyword:String, completion: @escaping (([MovieSearchResult])->Void)) {
        Common.shared.getMovies(search: keyword, at: pageNumber) { (movies, total) in
            self.pageCount = total / 10
            completion(movies)
        }
    }
    
    func next(keyword: String, completion: @escaping (([MovieSearchResult]) -> Void)) {
        self.nextMovies(keyword: keyword) {
            completion($0)
        }
    }
    
    func loadMore(keyword: String, completion: @escaping (([MovieSearchResult])->Void)) {
        if self.pageNumber < self.pageCount {
            self.pageNumber += 1
            self.nextMovies(keyword: keyword) {
                completion($0)
            }
        } else {
            completion([])
        }
    }
}
