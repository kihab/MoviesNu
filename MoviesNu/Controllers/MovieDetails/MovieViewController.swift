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
    
    override func viewDidLoad() {
        
        self.navigationItem.title = "Movie Details"
        populateMovieDetails()
    }
    
    func populateMovieDetails() {
        guard let movie = movieObject else {
            return
        }
        
        movieTitleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.release_date
    }
    
    
}
