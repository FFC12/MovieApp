//
//  MovieSearch.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//
import Foundation

struct MovieResponse: Decodable {
    let search: [MovieSearchResult]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}

struct MovieSearchResult: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: URL

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
