//
//  MoviesResponse.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesResponse: NSObject, Mappable {
    
    var movies: [MoviesShort]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        movies <- map["Search"]
    }
}
