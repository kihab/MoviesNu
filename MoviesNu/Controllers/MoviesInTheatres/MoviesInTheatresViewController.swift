//
//  ViewController.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import UIKit

protocol  MoviesInTheatresViewControllerProtocol: class {
    func populateMoviesViewWith(movies:[Movie])
}

class MoviesInTheatresViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var moviesInTheatresList:[Movie]?
    var presenter: MoviesInTheatresPresenterProtocol?
    var selectedMovie: Movie?
    var pageNumber = 1
    var loadingMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.moviesInTheatresViewControllerTitle
        
        let moviesService = MoviesService(urlFormatter: URLFormatter())
        presenter = MoviesInTheatresPresenter(viewController: self, moviesService: moviesService)
        guard let presenter = self.presenter else {
            print(Constants.showMoviesError)
            return
        }
        presenter.getMoviesWith(pageNumber: pageNumber)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showMovieDetailsSegue {
            guard let movieDetailsViewController = segue.destination as? MovieViewController,
            let movie = selectedMovie else {
                return
            }
            movieDetailsViewController.movieObject = movie
        }
    }
}

extension MoviesInTheatresViewController: MoviesInTheatresViewControllerProtocol {
    
    func populateMoviesViewWith(movies: [Movie]) {
        if moviesInTheatresList == nil {
            moviesInTheatresList = movies
        } else {
            moviesInTheatresList?.append(contentsOf: movies)
        }        
        moviesCollectionView.reloadData()
        loadingMovies = false
    }
}

extension MoviesInTheatresViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/1.4)
    }
}

extension MoviesInTheatresViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = moviesInTheatresList?.count else {
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.moviesViewCellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        guard let movies = moviesInTheatresList,
            let posterPath = movies[indexPath.row].poster_path else {
            return cell
                
        }
        
        presenter?.getMoviePoster(posterPath: posterPath, completionBlock: { (data, error) in
            
            guard let imageData = data, error == nil else {
                print(Constants.moviePosterError)
                return
            }
            cell.posterImage.image = UIImage(data: imageData)
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let movies = moviesInTheatresList,
        let moviesPresenter = presenter else {
            return
        }
        
        let lastElement = movies.count - 1
        if (!loadingMovies && indexPath.row == lastElement) {
            pageNumber += 1
            loadingMovies = true
            moviesPresenter.getMoviesWith(pageNumber: pageNumber)
        }
    }
}

extension MoviesInTheatresViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = moviesInTheatresList else {
            return
        }
        selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: Constants.showMovieDetailsSegue, sender: self)
    }
}
