//
//  UserDataService.swift
//  APIproj
//
//  Created by Admin on 28.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class DataService {
    
    static let sharedInstance = DataService()
    
    public func setUserVariables(userData : UserData, user_name : String, user_image_str : String) {
        userData.userName = user_name
        userData.userImageStr = user_image_str
    }
}
