//
//  MovieViewController.swift
//  MoviesNu
//
//  Created by Karim Ihab on 14/10/2018.
//  Copyright © 2018 Karim Ihab. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    var movieObject: Movie?
    var presenter: MoviePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.MovieDetailsViewControllerTitle
        presenter = MoviePresenter(moviesService: MoviesService(urlFormatter: URLFormatter()))
        populateMovieDetails()
    }
    
    func populateMovieDetails() {
        guard let movie = movieObject, let backdropImage = movieObject?.backdrop_path else {
            return
        }
        presenter?.getBackdropImage(backdropImage: backdropImage, completionBlock: { [weak self] (data, error) in
            guard let strongSelf = self,
                let imageData = data,
                error == nil else {
                print(Constants.moviebackdropImageError)
                return
            }
            strongSelf.backdropImageView.image = UIImage(data: imageData)
        })
        movieTitleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.release_date
    }
}
