//
//  MoviesInTheatresPresenterTests.swift
//  MoviesNuTests
//
//  Created by Karim Ihab on 15/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import XCTest
@testable import MoviesNu

class MoviesInTheatresViewControllerMock: MoviesInTheatresViewControllerProtocol {

    var moviesList: [Movie]?
    
    func populateMoviesViewWith(movies: [Movie]) {
        moviesList = movies
    }
}

class MoviesServiceMock: MoviesServiceProtocol {
    
    func getNowPlayingMoviesWith(pageNumber page: Int, andCompletionBlock completion: @escaping moviesCompletionBlock) {
        
        let mockMovie1 = Movie(title: "batman", poster_path: nil, backdrop_path: nil, overview: "overview", release_date: "")
        let mockMovie2 = Movie(title: "superman", poster_path: nil, backdrop_path: nil, overview: "overview", release_date: "")
        let list = [mockMovie1, mockMovie2]
        completion(list, nil)
    }
    
    func getMoviePosterWith(_ posterPath: String, completionBlock: @escaping movieImageCompletionBlock) {
        completionBlock(Data(), nil)
    }
    
    func getMovieBackdropWith(_ backdropPath: String, completionBlock: @escaping movieImageCompletionBlock) {}
    
    func getSearchResultsMoviesWith(searchQuery query: String, PageNumber page: Int, AndCompletionBlock completion: @escaping moviesCompletionBlock) {}
}

class MoviesInTheatresPresenterTests: XCTestCase {
    
    var moviesViewController : MoviesInTheatresViewControllerMock!
    var service : MoviesServiceMock!
    var presenter : MoviesInTheatresPresenter!
    
    override func setUp() {
        super.setUp()
        moviesViewController = MoviesInTheatresViewControllerMock()
        service = MoviesServiceMock()
        presenter = MoviesInTheatresPresenter(viewController: moviesViewController, moviesService: service)
    }
    
    override func tearDown() {
        super.tearDown()
        moviesViewController = nil
        service = nil
        presenter = nil
    }
    
    func testgetMoviePoster() {
        presenter.getMoviePoster(posterPath: "") { (data, error) in
            XCTAssertNotNil(data)
        }
    }
}
