//
//  MoviePresenter.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

protocol MoviePresenterProtocol {
    func getBackdropImage(backdropImage: String, completionBlock: @escaping movieImageCompletionBlock)
}

class MoviePresenter: MoviePresenterProtocol {
    
    var service:MoviesServiceProtocol
    
    init(moviesService: MoviesServiceProtocol) {
        service = moviesService
    }
    
    func getBackdropImage(backdropImage: String, completionBlock: @escaping movieImageCompletionBlock) {
        service.getMovieBackdropWith(backdropImage) {(data, error) in
            guard let imageData = data, error == nil  else {
                print(Constants.moviebackdropImageError)
                return
            }
            completionBlock(imageData, nil)
        }
    }
}
