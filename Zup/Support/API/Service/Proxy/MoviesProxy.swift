//
//  MoviesProxy.swift
//  Zup
//
//  Created by Victor de Paula on 01/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation

class MoviesProxy : NSObject {
    
    let api : RestAPI = RestAPI()
    public func getMovies(url: URL, onCompletion: @escaping (_ result: String) -> Void,
                            onFailure: @escaping (_ error:Error) -> Void){
        
        api.restApiGet(url: url, onCompletion:{(result: String) -> Void in
            onCompletion(result)
            
        }, onFailure:{(error:Error) -> Void in
            onFailure(error)
            
        })
        
    }
}

