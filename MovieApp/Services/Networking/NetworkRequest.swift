//
//  Request.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

// This is the base request protocol for all requests that will be derived from it
protocol NetworkRequest {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get set }
    var body: Data? { get }
    
    func asURLRequest() throws -> URLRequest
}

// Implementation of NetworkRequest for building HTTP request (URL)
extension NetworkRequest {
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponents?.url else {
            throw NetworkError.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        
        #if DEBUG
        print("Request URL: \(urlRequest)")
        #endif
        
        return urlRequest
    }
}

