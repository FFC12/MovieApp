//
//  NetworkService.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

class GenericNetworkService: NetworkService {
    private let urlSession : URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T>(request: NetworkRequest, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        do {
            let httpRequest = try request.asURLRequest()
            let task = urlSession.dataTask(with: httpRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            }
            
            task.resume()
            
        } catch {
            completion(.failure(.requestFailed(error)))
        }
    }
}
