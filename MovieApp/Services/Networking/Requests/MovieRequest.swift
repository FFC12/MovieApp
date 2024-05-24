//
//  MovieRequest.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//
import Foundation

/// We will use this request to get movie and its details
class MovieRetrieveRequest: NetworkRequest {
    var baseURL: URL {
        return URL(string: Constants.kBaseURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    var queryParameters: [String : String]
    
    var body: Data? {
        return nil
    }

    init(queryParameters: [String: String]) {
        self.queryParameters = ["apikey": Constants.kAPIKey]
        self.queryParameters.merge(queryParameters) { (_, new) in new }
    }
}

