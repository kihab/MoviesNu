//
//  URLFormatterTests.swift
//  MoviesNuTests
//
//  Created by Karim Ihab on 15/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import XCTest
@testable import MoviesNu

class URLFormatterTests: XCTestCase {
    
    let formatter = URLFormatter()
    override func setUp() {
        super.setUp()
    }
    
    func testGetNowPlayingMoviesURL() {
        let url = formatter.getNowPlayingMoviesURLWith(pageNumber: 1)
        print(url)
        XCTAssertEqual(url, "https://api.themoviedb.org/3/movie/now_playing?api_key=135565bc324206c4fb933a85f40a9bfa&language=en-US&page=1")
    }
    
    func testGetMoviePosterURL() {
        let url = formatter.getMoviePosterURL(posterId: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
        print(url)
        XCTAssertEqual(url, "https://image.tmdb.org/t/p/w200/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
    }
    
    func testGetMovieBackdropImageURL() {
        let url = formatter.getMovieBackdropImageURL(backdroId: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
        print(url)
        XCTAssertEqual(url, "https://image.tmdb.org/t/p/w400/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
    }

    func testGetSearchMoviesURLWith() {
        let url = formatter.getSearchMoviesURLWith(searchQuery: "batman", andPage: 1)
        print(url)
        XCTAssertEqual(url, "https://api.themoviedb.org/3/search/movie?api_key=135565bc324206c4fb933a85f40a9bfa&language=en-US&query=batman&page=1")
    }
}
