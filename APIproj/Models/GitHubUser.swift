

import Foundation
import RealmSwift

class GitHubUser : User {
    
    let searchString:String = "https://api.github.com/search/users?q="
    let parser : ParserData = ParserData(str_for_login_parse: "login", str_for_image: "avatar_url", str_for_item: "items")
    
    override func getUsersFromJSON(querry : String, completion: @escaping ([User]) -> Void){
        var users : [User] = []
        
        DownloaderJSON.sharedInstance.downloadJSON(searchString: searchString + querry, ItemKey: parser.stringForItemParse) {
            items in
            for item in items {
                var userD = item as! NSDictionary
                var user : GitHubUser = GitHubUser()
                DataService.sharedInstance.setUserVariables(userData: user.userData!,
                                                            user_name: userD.value(forKey: user.parser.stringForLoginParse) as! String,
                                                            user_image_str: userD.value(forKey: user.parser.stringForImageParse) as! String)
                users.append(user)
                
            }
            completion(users)
        }

    }
    
}
