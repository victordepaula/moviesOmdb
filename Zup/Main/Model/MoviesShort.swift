//
//  MoviesShort.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import ObjectMapper


class MoviesShort:  NSObject, Mappable {
    var title: String?
    var yearMovie: String?
    var posterMovie: String?
    var imdbID: String?
    var type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map : Map) {
        self.title <- map["Title"]
        self.yearMovie <- map["Year"]
        self.posterMovie <- map["Poster"]
        self.type <- map["Type"]
        self.imdbID <- map["imdbID"]
    }
}

