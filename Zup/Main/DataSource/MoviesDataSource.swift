//
//  MoviesDataSource.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation

@objc protocol MoviesDataSourceProtocol: GenericDataSource {
     func responseMovies(movies: [MoviesResponse])
     func responseMovieById(movies: [Movie])
}

class MovieDataSource: DataSourceManager<MoviesDataSourceProtocol, Any> {
    func requestMovies(person: String) {
        MoviesApplication().moviesByName(onSuccess: { (movies) in
            self.dataSourceDelegate!.responseMovies(movies: movies)
        }, onFailureMessage: { (error) in
            self.dataSourceDelegate?.errorData(self.dataSourceDelegate, error: error)
        }, onFailure: { (error) in
              self.dataSourceDelegate?.errorData(self.dataSourceDelegate, error: error)
        }, stringForSearch: person)
    }
    
    func requestMovieById(id : String){
            MoviesApplication().moviesById(onSuccess: { (movies) in
                self.dataSourceDelegate!.responseMovieById(movies: movies)
            }, onFailureMessage: { (error) in
                self.dataSourceDelegate?.errorData(self.dataSourceDelegate, error: error)
            }, onFailure: { (error) in
                self.dataSourceDelegate?.errorData(self.dataSourceDelegate, error: error)
            }, stringForSearch: id)
    }
}

