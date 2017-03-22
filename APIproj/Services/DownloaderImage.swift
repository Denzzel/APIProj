//
//  DownloaderImage.swift
//  APIproj
//
//  Created by Admin on 20.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

class DownloaderImage : NSObject {

    static let sharedInstance = DownloaderImage()
    
    public func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
        }
    }
}
