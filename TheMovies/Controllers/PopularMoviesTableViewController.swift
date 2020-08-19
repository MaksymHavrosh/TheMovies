//
//  PopularMoviesTableViewController.swift
//  TheMovies
//
//  Created by MG on 19.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit
import Network

class PopularMoviesTableViewController: UITableViewController {
    
    private let networkMonitor = NWPathMonitor()
    private var alert = UIAlertController()
    
    private var movies = [Movie]()
    private var page = 1
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAlertController()
        addPathUpdateHandler()
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
    
}

//MARK: - UITableViewDelegate

extension PopularMoviesTableViewController {
    
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
            print(movies)
        }
    }
    
    func createAlertController() {
        
        alert = UIAlertController(title: NSLocalizedString("Ошибка!", comment: ""), message: NSLocalizedString("Нет соединения", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Настройки", comment: ""), style: .default, handler: { _ in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:])
        }))
    }
    
    func addPathUpdateHandler() {
        
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                
                if path.status == .unsatisfied, !self.alert.isFirstResponder {
                    self.present(self.alert, animated: true, completion: nil)
                    
                } else {
                    self.alert.dismiss(animated: true, completion: nil)
                    self.tableView.reloadData()
                }
            }
        }
        networkMonitor.start(queue: DispatchQueue.main)
    }
    
}

