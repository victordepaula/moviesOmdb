//
//  MovieData.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation


class MovieData: AbstractData {
    
    static let sharedInstance: MovieData = {
        let instance = MovieData(entityName: Entity.movies.rawValue)
        return instance
    }()
    
    init(entityName: String) {
        super.init()
        self.entityName = entityName
    }
    
    func saveMovie(_ data: Movie) -> Any? {
        var dictionary: [String: Any] = [:]
        dictionary["id"] = data.id
        dictionary["actors"] = data.actors
        dictionary["awards"] = data.awards
        dictionary["country"] = data.country
        dictionary["director"] = data.director
        dictionary["genre"] = data.genre
        dictionary["language"] = data.language
        dictionary["plot"] = data.plot
        dictionary["rated"] = data.rated
        dictionary["released"] = data.released
        dictionary["runtime"] = data.runtime
        dictionary["title"] = data.title
        dictionary["writer"] = data.writer
        dictionary["year"] = data.year
        dictionary["poster"] = data.moviedata
        let result = self.save(dictionary)
        return result ?? ""
    }
    
    
    func getAllMovies() -> [Movie]? {
        var moviesArray = [Movie]()
        let result = get()
        let fetchCountry = result as! [Movies]
        
        for index in 0..<fetchCountry.count {
            let movie = Movie()
            movie.id = fetchCountry[index].id
            movie.actors = fetchCountry[index].actors
            movie.awards = fetchCountry[index].awards
            movie.country = fetchCountry[index].country
            movie.director = fetchCountry[index].director
            movie.genre = fetchCountry[index].genre
            movie.language = fetchCountry[index].language
            movie.plot = fetchCountry[index].plot
            movie.rated = fetchCountry[index].rated
            movie.runtime = fetchCountry[index].runtime
            movie.title = fetchCountry[index].title
            movie.writer = fetchCountry[index].writer
            movie.year = fetchCountry[index].year
            movie.moviedata = fetchCountry[index].poster
            
            moviesArray.append(movie)
        }
        return moviesArray
    }
    
    func getMoviesWithId(movieId: String) -> [Movie]? {
        var moviesArray = [Movie]()
        let result = getMovieId(movieId, atributte: .profile)
        let fetchCountry = result as! [Movies]
        for index in 0..<fetchCountry.count {
            let movie = Movie()
            movie.id = fetchCountry[index].id
            movie.actors = fetchCountry[index].actors
            movie.awards = fetchCountry[index].awards
            movie.country = fetchCountry[index].country
            movie.director = fetchCountry[index].director
            movie.genre = fetchCountry[index].genre
            movie.language = fetchCountry[index].language
            movie.plot = fetchCountry[index].plot
            movie.rated = fetchCountry[index].rated
            movie.runtime = fetchCountry[index].runtime
            movie.title = fetchCountry[index].title
            movie.writer = fetchCountry[index].writer
            movie.year = fetchCountry[index].year
            moviesArray.append(movie)
        }
        return moviesArray
    }
    func removeMovie(currentUserID: String?) -> Bool? {
        let isSuccess = removeMovieWithId(value: currentUserID, attribute: .profile)
        return isSuccess
    }
}

