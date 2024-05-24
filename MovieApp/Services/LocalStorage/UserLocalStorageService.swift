//
//  UserLocalStorageService.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import Foundation

class UserLocalStorageService: UserLocalStorage {
    func save(key: String, value: [String:String]?) {
        // check if it's already exists that key
        if UserDefaults.standard.object(forKey: key) != nil {
            var oldValue = UserDefaults.standard.value(forKey: key) as? [[String:String]]
            delete(key: key)
            // check if value is already exists
            if oldValue?.contains(where: { $0["id"] == value?["id"] }) ?? false {
                return
            }
            oldValue?.append(value!)
            UserDefaults.standard.set(oldValue, forKey: key)
        } else {
            UserDefaults.standard.set([value], forKey: key)
        }
    }
    
    func get(key: String) -> [[String:String]]? {
        return UserDefaults.standard.value(forKey: key) as? [[String:String]]
    }
    
    func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
