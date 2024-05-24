//
//  UserLocalStorage.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

protocol UserLocalStorage {
    func save(key: String, value: [String:String]?)
    func get(key: String) -> [[String:String]]?
    func delete(key: String)
}
