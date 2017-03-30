//
//  DBservice.swift
//  APIproj
//
//  Created by Admin on 30.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class DBservice {
    static let sharedInstance = DBservice()
    
    let realm = try! Realm()
    
    func writeUser(user : User) {
        try! self.realm.write {
            realm.add(user)
        }
    }
    
    public func writeArrayOfUsers(users : [User]) {
        for user in users {
            writeUser(user: user)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
}
