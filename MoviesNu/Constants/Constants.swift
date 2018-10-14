//
//  Constants.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import Foundation

class Constants {
    
    //Views Identifiers
    static let moviesViewCellIdentifier = "MoviesCell"
    

    //ViewControllers Title
    static let moviesInTheatresViewControllerTitle = "Movies In Theatres"
    
    //Segues
    static let showMovieDetailsSegue = "showMovieDetails"
    
    //Errors
    static let showMoviesError = "ERROR: Can't get movies"
    static let nowPlayingMoviesURLError = "Couldn't get now playing movies URL"
    static let noMoviesFound = "Couldn't found any movies"
    static let moviePosterError = "Can't get Movie poster"
    
    //Movies URLs
    static let baseURL = "https://api.themoviedb.org/3/"
    
    //API_KEYS
    static let apiKey = "135565bc324206c4fb933a85f40a9bfa"
}
