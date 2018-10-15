//
//  URLFormatter.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

protocol URLFormatterProtocol {
    
    func getNowPlayingMoviesURLWith(pageNumber page:Int) -> String
    func getMoviePosterURL(posterId: String) -> String
    func getMovieBackdropImageURL(backdroId: String) -> String
}

class URLFormatter: URLFormatterProtocol {
    
    func getNowPlayingMoviesURLWith(pageNumber page: Int) -> String {
        return "\(Constants.baseURL)movie/now_playing?api_key=\(Constants.apiKey)&page=\(String(page))"
    }
    
    func getMoviePosterURL(posterId: String) -> String {
        return "https://image.tmdb.org/t/p/w200\(posterId)"
    }
    
    func getMovieBackdropImageURL(backdroId: String) -> String {
        return "https://image.tmdb.org/t/p/w400\(backdroId)"
    }
}
