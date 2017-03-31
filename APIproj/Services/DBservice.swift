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
    
    public func crearDB() {
        try! self.realm.write {
            realm.deleteAll()
        }
    }
    
    
    public func getCashedUsers() -> [User] {
        var users : [User] = []
        var userList : Results<User>!
        var gitUserList : Results<GitHubUser>!
        var itunesUserList : Results<ITunesUser>!
        
        userList = self.realm.objects(User)
        for user in userList {
            users.append(user)
        }
        gitUserList = self.realm.objects(GitHubUser)
        for user in gitUserList {
            users.append(user)
        }
        itunesUserList = self.realm.objects(ITunesUser)
        for user in itunesUserList {
            users.append(user)
        }
        
        return users
    }
    
}
