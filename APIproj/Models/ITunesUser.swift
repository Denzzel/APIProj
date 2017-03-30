
import Foundation
import RealmSwift

class ITunesUser : User {
    
    let searchString:String = "https://itunes.apple.com/search?term="
    let parser : ParserData = ParserData(str_for_login_parse: "artistName", str_for_image: "artworkUrl100", str_for_item: "results")
    
    override func getUsersFromJSON(querry : String, completion: @escaping ([User]) -> Void){
        var users : [User] = []
        
        DownloaderJSON.sharedInstance.downloadJSON(searchString: searchString + querry, ItemKey: parser.stringForItemParse) {
            items in
            for item in items {
                var userD = item as! NSDictionary
                var user : ITunesUser = ITunesUser()
                DataService.sharedInstance.setUserVariables(userData: user.userData!,
                                                            user_name: userD.value(forKey: user.parser.stringForLoginParse) as! String,
                                                            user_image_str: userD.value(forKey: user.parser.stringForImageParse) as! String)
                users.append(user)
                
            }
            completion(users)
        }
        
    }
    
}
