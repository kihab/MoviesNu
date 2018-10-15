//
//  MovieModel.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//


struct MoviesResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let poster_path: String?
    let backdrop_path: String?
    let overview: String
    let release_date: String
}
