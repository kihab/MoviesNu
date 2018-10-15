//
//  MoviesService.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import UIKit

typealias moviesCompletionBlock = (_ movies:[Movie]?, _ error: Error?) -> Void
typealias movieImageCompletionBlock = (_ imageData:Data?, _ error: Error?) -> Void


protocol MoviesServiceProtocol {
    
    func getNowPlayingMoviesWith(pageNumber page:Int, andCompletionBlock completion: @escaping moviesCompletionBlock)
    func getMoviePosterWith(_ posterPath: String, completionBlock:  @escaping movieImageCompletionBlock)
    func getMovieBackdropWith(_ backdropPath: String, completionBlock:  @escaping movieImageCompletionBlock)
    func getSearchResultsMoviesWith(searchQuery query:String, PageNumber page:Int, AndCompletionBlock completion: @escaping moviesCompletionBlock)
}

class MoviesService: MoviesServiceProtocol {
    
    var urlFomatter: URLFormatter?
    
    init(urlFormatter: URLFormatter) {
        self.urlFomatter = urlFormatter
    }
    
    func getNowPlayingMoviesWith(pageNumber page:Int, andCompletionBlock completion: @escaping moviesCompletionBlock) {
        guard let formatter = self.urlFomatter,
        let url = URL(string: formatter.getNowPlayingMoviesURLWith(pageNumber: page)) else {
            print(Constants.nowPlayingMoviesURLError)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil, error)
            }
            
            guard let data = data else { return }
            
            do {
                let nowPlayingResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                let movies = nowPlayingResponse.results
                if (movies.count > 0) {
                    completion(movies, nil)
                } else {
                    print(Constants.noMoviesFound)
                }
                
                
            } catch let jsonError {
                print(jsonError)
                completion(nil, jsonError)
            }
            
            }.resume()
    }
    
    func getMoviePosterWith(_ posterPath: String, completionBlock: @escaping movieImageCompletionBlock) {
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
    
    func getMovieBackdropWith(_ backdropPath: String, completionBlock:  @escaping movieImageCompletionBlock) {
        guard let formatter = self.urlFomatter else {
            print(Constants.moviePosterError)
            return
        }
        
        let backdropURLImage = formatter.getMovieBackdropImageURL(backdroId: backdropPath)
        guard let url = URL(string: backdropURLImage) else {
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
    
    func getSearchResultsMoviesWith(searchQuery query:String, PageNumber page:Int, AndCompletionBlock completion: @escaping moviesCompletionBlock) {
        guard let formatter = self.urlFomatter,
            let url = URL(string: formatter.getSearchMoviesURLWith(searchQuery: query, andPage: page)) else {
                print(Constants.moviesSearchError)
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil, error)
            }
            
            guard let data = data else { return }
            
            do {
                let searchResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                let movies = searchResponse.results
                if (movies.count > 0) {
                    completion(movies, nil)
                } else {
                    print(Constants.noMoviesFound)
                }
                
                
            } catch let jsonError {
                print(jsonError)
                completion(nil, jsonError)
            }
            
            }.resume()
    }
}
