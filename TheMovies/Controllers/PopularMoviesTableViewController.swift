//
//  PopularMoviesTableViewController.swift
//  TheMovies
//
//  Created by MG on 19.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit

class PopularMoviesTableViewController: UITableViewController {
    
    private var movies = [Any]()
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPopularMoviesFromServer()
        
    }
    
}

//MARK: - Private

private extension PopularMoviesTableViewController {
    
    func getPopularMoviesFromServer() {
        
        ServerManager.getPopularMovies { (movies) in
            self.movies = movies
            print(movies)
        }
        
    }
    
}

