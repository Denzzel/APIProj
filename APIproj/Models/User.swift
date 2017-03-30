//
//  User.swift
//  APIproj
//
//  Created by Admin on 27.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    

    dynamic var userData : UserData? = UserData()
    
    public func getUsersFromJSON(querry : String, completion: @escaping ([User]) -> Void) {

    }
    
}
