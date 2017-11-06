//
//  MoviesApplication.swift
//  Zup
//
//  Created by Victor de Paula on 01/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesApplication : NSObject {
    private func baseServiceUrl() -> String {
        return  URLInfo.url(fromKey: "baseUrlService")
    }
    
    private func baseUrlAppendingUrlKey(key: String) -> String {
        return  baseServiceUrl() + URLInfo.url(fromKey: key)
    }
    
    private func getUrlMovieById(userId: String) -> String {
        let url = baseUrlAppendingUrlKey(key: "getMovieById")
        return url.replacingOccurrences(of: "{id}", with: userId)
        
    }
    
    private func getUrlMovieByName(personId: String) -> String {
        let url = baseUrlAppendingUrlKey(key: "getMovieByNameLiteral")
        return url.replacingOccurrences(of: "{id}", with: personId)
    }
    
    func  moviesById(onSuccess: @escaping (_ result: [Movie]) -> Void, onFailureMessage: @escaping (_ failureMessage: Error)-> Void, onFailure: @escaping (_ failure:Error)-> Void, stringForSearch: String){
        guard let url = URL(string: getUrlMovieById(userId: stringForSearch)) else {
            return
        }
        MoviesProxy().getMovies(url:  url, onCompletion: {(response: String) -> Void in
            let mapper = Mapper<Movie>()
            let countries = mapper.mapArray(JSONString: response)
            if let countries = countries{
                onSuccess(countries)
            }
            
        }, onFailure: {(error:Error) -> Void in
            onFailure(error)
            
        })
    }
    func  moviesByName(onSuccess: @escaping (_ result: [MoviesResponse]) -> Void, onFailureMessage: @escaping (_ failureMessage: Error)-> Void, onFailure: @escaping (_ failure:Error)-> Void,stringForSearch: String){
        var stringReplaced = stringForSearch.replacingOccurrences(of: " ", with: "_")
        guard let url = URL(string: getUrlMovieByName(personId: stringReplaced.lowercased())) else {
            return
        }
        MoviesProxy().getMovies(url: url, onCompletion: {(response: String) -> Void in
            let mapper1 = Mapper<MoviesResponse>()
            let countries1 = mapper1.mapArray(JSONString: response)
            if let countries = countries1{
                onSuccess(countries)
            }
        }, onFailure: {(error:Error) -> Void in
            onFailure(error)

        })
    }
    
}
