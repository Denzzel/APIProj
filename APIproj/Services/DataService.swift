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
    
    public func getGitUsersFromJSON(querry : String, completion: @escaping ([User]) -> Void){
        var users : [User] = []
        let parser : ParserData = ParserData(str_for_login_parse: "login", str_for_image: "avatar_url", str_for_item: "items")
        let searchString:String = "https://api.github.com/search/users?q="

        if (Connection.sharedInstance.isInternetAvailable()) {
            DownloaderJSON.sharedInstance.downloadJSON(searchString: searchString + querry, ItemKey: parser.stringForItemParse) {
                items in
                for item in items {
                    var userD = item as! NSDictionary
                    var user : User = GitHubUser()
                    DataService.sharedInstance.setUserVariables(userData: user.userData!,
                                                                user_name: userD.value(forKey: parser.stringForLoginParse) as! String,
                                                                user_image_str: userD.value(forKey: parser.stringForImageParse) as! String)
                    users.append(user)
                
                }
                DBservice.sharedInstance.writeArrayOfUsersWithClear(users: users)
                completion(users)
            }
        } else {
            users = DBservice.sharedInstance.getCashedUsers()
            
            completion(users)
        }
        
    }
    
    public func getItunesUsersFromJSON(querry : String, completion: @escaping ([User]) -> Void){
        var users : [User] = []
        let searchString:String = "https://itunes.apple.com/search?term="
        let parser : ParserData = ParserData(str_for_login_parse: "artistName", str_for_image: "artworkUrl100", str_for_item: "results")
        if (Connection.sharedInstance.isInternetAvailable()) {
            DownloaderJSON.sharedInstance.downloadJSON(searchString: searchString + querry, ItemKey: parser.stringForItemParse) {
                items in
                for item in items {
                    var userD = item as! NSDictionary
                    var user : User = ITunesUser()
                    DataService.sharedInstance.setUserVariables(userData: user.userData!,
                                                                user_name: userD.value(forKey: parser.stringForLoginParse) as! String,
                                                                user_image_str: userD.value(forKey: parser.stringForImageParse) as! String)
                    users.append(user)
                    
                }
                DBservice.sharedInstance.writeArrayOfUsersWithClear(users: users)
                completion(users)
            }
        } else {
            users = DBservice.sharedInstance.getCashedUsers()
            
            completion(users)
        }
        
    }


}
