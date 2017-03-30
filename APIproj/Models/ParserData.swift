//
//  ParserData.swift
//  APIproj
//
//  Created by Admin on 29.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class ParserData {
    
    var stringForLoginParse = ""
    var stringForItemParse = ""
    var stringForImageParse = ""
    
    init(str_for_login_parse : String, str_for_image : String, str_for_item : String) {
        stringForImageParse = str_for_image
        stringForItemParse = str_for_item
        stringForLoginParse = str_for_login_parse
    }
}
