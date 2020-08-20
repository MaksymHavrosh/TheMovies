//
//  PopularMoviesTableViewController.swift
//  TheMovies
//
//  Created by MG on 19.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit

class PopularMoviesTableViewController: UITableViewController {
    
    private var movies = [Movie]()
    private var selectedMovie: Movie?
    private var page = 1
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMoviesFromServer()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController {
            vc.movie = selectedMovie
        }
    }
    
}

//MARK: - UITableViewDelegate

extension PopularMoviesTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMovie = movies[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard indexPath.row == movies.count - 1 else { return }
        self.page += 1
        getPopularMoviesFromServer()
    }
    
}

//MARK: - Private

private extension PopularMoviesTableViewController {
    
    func getPopularMoviesFromServer() {
        
        ServerManager.getPopularMovies(page: page) { (movies) in
            self.movies.append(contentsOf: movies)
            self.tableView.reloadData()
        }
    }
    
}

