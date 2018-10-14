//
//  MoviesInTheatresPresenter.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import UIKit

protocol MoviesInTheatresPresenterProtocol {
    
    func getMovies()
    func getMoviePoster(posterPath: String, completionBlock: @escaping moviePosterCompletionBlock)
}

class MoviesInTheatresPresenter: MoviesInTheatresPresenterProtocol {
    
    weak var viewController: MoviesInTheatresViewControllerProtocol?
    var service:MoviesServiceProtocol
    
    init(viewController: MoviesInTheatresViewControllerProtocol, moviesService: MoviesServiceProtocol) {
        self.viewController = viewController
        service = moviesService
    }
    
    func getMovies() {
        service.getNowPlayingMoviesWith { (movies, error) in
            guard let moviesNowPlaying = movies, error == nil else {
                print("\(Constants.showMoviesError): \(error?.localizedDescription ?? "ERROR")")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.populateMoviesViewWith(movies: moviesNowPlaying)
            }
        }
    }
    
    func getMoviePoster(posterPath: String, completionBlock: @escaping moviePosterCompletionBlock) {        
        service.getMoviePosterWith(posterPath) { (data, error) in
            guard let imageData = data, error == nil  else {
                print(Constants.moviePosterError)
                return
            }
            completionBlock(imageData, nil)
        }
    }
}
