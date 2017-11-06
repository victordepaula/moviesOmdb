//
//  Movie.swift
//  Zup
//
//  Created by Victor de Paula on 01/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie : NSObject, Mappable {
    var id : String?
    var title: String?
    var genre: String?
    var released: String?
    var poster: String?
    var runtime: String?
    var year: String?
    var rated: String?
    var language: String?
    var country: String?
    var awards: String?
    var actors: String?
    var writer: String?
    var director: String?
    var plot: String?
    var moviedata : NSData?
    var dictionary: [String : String] = [String :  String]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override init() {
        
    }
    
    func unwrap(any:Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }
    func nullToNil(value : Any?) -> Any? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
    func convertFieldsToDictionary() {
        let bookMirror = Mirror(reflecting: self )
        for (name, value) in bookMirror.children {
            guard let name   = name else { continue }
            if name != "moviedata" && name != "poster" && name != "id" && name != "dictionary" && name != "title"{
                let value1 = unwrap(any: value)
                if nullToNil(value: value1) != nil  {
                    self.dictionary[name] =   String(describing: value1)
                }
            }
        }
    }
    
    func mapping(map : Map) {
        self.title <- map["Title"]
        self.genre <-  map["Genre"]
        self.released <- map["Released"]
        self.runtime <- map["Runtime"]
        self.poster <- map["Poster"]
        self.director <- map["Director"]
        self.writer <- map["Writer"]
        self.actors <- map["Actors"]
        self.plot <- map["Plot"]
        self.language <- map["Language"]
        self.country <- map["Country"]
        self.awards <- map["Awards"]
        self.rated <- map["Rated"]
        self.year <- map["labelYear"]
    }
}

