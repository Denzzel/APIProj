//
//  DownloaderJSON.swift
//  APIproj
//
//  Created by Admin on 19.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import Alamofire

class DownloaderJSON : NSObject {

    static func downloadJSON(searchString : String, ItemKey: String, completion: @escaping (NSArray) -> Void) {
        Alamofire.request(searchString).responseJSON {
            response in
            guard let json = response.result.value! as? NSDictionary else { return }
            guard let items = json.value(forKey: ItemKey) as? NSArray else { return }
            completion(items)
        }
    }
}
