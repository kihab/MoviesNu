//
//  MoviesServiceTests.swift
//  MoviesNuTests
//
//  Created by Karim Ihab on 15/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import XCTest
@testable import MoviesNu

class MoviesServiceTests: XCTestCase {
    
    let service = MoviesService(urlFormatter: URLFormatter())
    
    override func setUp() {
        super.setUp()
    }
    
    //Asynchronus Tests
    
    func testGetNowPlayingMovies() {
        let nowPlayingExpectation = expectation(description: "now playing movies test")
        
        service.getNowPlayingMoviesWith(pageNumber: 1) { (movies, error) in
            XCTAssertNotNil(movies)
            XCTAssertGreaterThan(movies!.count, 0)
            nowPlayingExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testGetMoviePoster() {
        let posterExpectation = expectation(description: "poster test")

        service.getMoviePosterWith("/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg") { (data, error) in
            XCTAssertNotNil(data)
            posterExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    
}
