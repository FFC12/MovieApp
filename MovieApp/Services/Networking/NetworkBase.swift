//
//  Base.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol NetworkService {
    func fetchData<T: Codable>(request: NetworkRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}
