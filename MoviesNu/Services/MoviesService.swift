//
//  MoviesService.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import UIKit

typealias nowPlayingMoviesCompletionBlock = (_ movies:[Movie]?, _ error: Error?) -> Void
typealias moviePosterCompletionBlock = (_ imageData:Data?, _ error: Error?) -> Void


protocol MoviesServiceProtocol {
    
    func getNowPlayingMoviesWith(completionBlock: @escaping nowPlayingMoviesCompletionBlock)
    
    func getMoviePosterWith(_ posterPath: String, completionBlock:  @escaping moviePosterCompletionBlock)
}

class MoviesService: MoviesServiceProtocol {
    
    var urlFomatter: URLFormatter?
    
    init(urlFormatter: URLFormatter) {
        self.urlFomatter = urlFormatter
    }
    
    func getNowPlayingMoviesWith(completionBlock: @escaping nowPlayingMoviesCompletionBlock) {
        
        guard let formatter = self.urlFomatter,
        let url = URL(string: formatter.getNowPlayingMoviesURL()) else {
            print(Constants.nowPlayingMoviesURLError)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionBlock(nil, error)
            }
            
            guard let data = data else { return }
            
            do {
                let nowPlayingResponse = try JSONDecoder().decode(NowPlaying.self, from: data)
                let movies = nowPlayingResponse.results
                if (movies.count > 0) {
                    completionBlock(movies, nil)
                } else {
                    print(Constants.noMoviesFound)
                }
                
                
            } catch let jsonError {
                print(jsonError)
                completionBlock(nil, jsonError)
            }
            
            }.resume()
    }
    
    func getMoviePosterWith(_ posterPath: String, completionBlock: @escaping moviePosterCompletionBlock) {
        
        guard let formatter = self.urlFomatter else {
            print(Constants.moviePosterError)
            return
        }
        
        let posterURLImage = formatter.getMoviePosterURL(posterId: posterPath)
        guard let url = URL(string: posterURLImage) else {
            print(Constants.moviePosterError)
            return
        }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                completionBlock(data, nil)
            }
        }
    }
}
