//
//  DetailViewController.swift
//  TheMovies
//
//  Created by MG on 20.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit
import AVKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    
    var movie: Any?
    var videos = [Video]()
    var selectVideo: Video?
    
    var fetchedResultsController = FavotiteMoviesTableViewController().fetchedResultsController
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        if let movie = movie as? FavoriteMovie {
            addToFavoriteButton.backgroundColor = .gray
            addToFavoriteButton.setTitle(NSLocalizedString("Удалить с избранных", comment: ""), for: .normal)
            
            nameLabel.text = movie.title
            dateLabel.text = movie.releaseDate
            overviewTextView.text = movie.overview
            getVideosBy(Int(movie.id))
            
        } else if let movie = movie as? Movie {
            nameLabel.text = movie.title
            dateLabel.text = movie.releaseDate
            overviewTextView.text = movie.overview
            getVideosBy(movie.id)
            
            guard let favoriteMovies = fetchedResultsController.fetchedObjects else { return }
            
            for object in favoriteMovies {
                guard movie.id == (object as! FavoriteMovie).id else { continue }
                addToFavoriteButton.setTitle(NSLocalizedString("Удалить с избранных", comment: ""), for: .normal)
                addToFavoriteButton.backgroundColor = .gray
            }
        }
        
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? VideoViewController, let key = selectVideo?.key, let url = URL(string: "https://www.youtube.com/watch?v=" + key) {
            vc.urlVideo = url
        }
    }

}

//MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        cell.textLabel?.text = videos[indexPath.row].name
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectVideo = videos[indexPath.row]
        self.performSegue(withIdentifier: "ShowVideo", sender: self)
    }
    
}

//MARK: - Actions

private extension DetailViewController {
    
    @IBAction func addToFavoritesOrDeleteFromFavorites(_ sender: UIButton) {
        var context: NSManagedObjectContext?
        
        if sender.titleLabel?.text == NSLocalizedString("Удалить с избранных", comment: "") {
            context = deleteFromFavorites()
        } else {
            context = addToFavorites()
        }
        do {
            try context?.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        fetchedResultsController = FavotiteMoviesTableViewController().fetchedResultsController
    }
    
}

//MARK: - Private

private extension DetailViewController {
    
    func getVideosBy(_ movieID: Int) {
        
        ServerManager.getVideosByMovieId(id: movieID, success: { videos in
            self.videos.append(contentsOf: videos)
            self.tableView.reloadData()
        })
    }
    
    func deleteFromFavorites()  -> NSManagedObjectContext? {
        
        guard let favoriteMovies = fetchedResultsController.fetchedObjects else { return nil }
        addToFavoriteButton.setTitle(NSLocalizedString("Добавить в избранные", comment: ""), for: .normal)
        addToFavoriteButton.backgroundColor = .systemTeal
        var index: Int?
        
        if let movie = movie as? FavoriteMovie {
            
            for object in favoriteMovies {
                guard movie.id == (object as! FavoriteMovie).id else { continue }
                index = favoriteMovies.firstIndex { $0 === object }
            }
            
        } else if let movie = movie as? Movie {
            
            for object in favoriteMovies {
                guard movie.id == (object as! FavoriteMovie).id else { continue }
                index = favoriteMovies.firstIndex { $0 === object }
            }
        }
        
        guard let i = index else { return nil }
        let context = fetchedResultsController.managedObjectContext
        context.delete(fetchedResultsController.fetchedObjects?[i] as! NSManagedObject)
        
        return context
    }
    
    func addToFavorites() -> NSManagedObjectContext? {
        
        guard let movie = movie as? Movie else { return nil }
        addToFavoriteButton.setTitle(NSLocalizedString("Удалить с избранных", comment: ""), for: .normal)
        addToFavoriteButton.backgroundColor = .gray
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: context) else { return nil }
        let favoriteMovie = NSManagedObject(entity: entity, insertInto: context)
        
        favoriteMovie.setValue(movie.adult, forKey: "adult")
        favoriteMovie.setValue(movie.backdropPath, forKey: "backdropPath")
        favoriteMovie.setValue(movie.genreIds, forKey: "genreIds")
        favoriteMovie.setValue(movie.id, forKey: "id")
        favoriteMovie.setValue(movie.originalLanguage, forKey: "originalLanguage")
        favoriteMovie.setValue(movie.originalTitle, forKey: "originalTitle")
        favoriteMovie.setValue(movie.overview, forKey: "overview")
        favoriteMovie.setValue(movie.popularity, forKey: "popularity")
        favoriteMovie.setValue(movie.posterPath, forKey: "posterPath")
        favoriteMovie.setValue(movie.releaseDate, forKey: "releaseDate")
        favoriteMovie.setValue(movie.title, forKey: "title")
        favoriteMovie.setValue(movie.video, forKey: "video")
        favoriteMovie.setValue(movie.voteAverage, forKey: "voteAverage")
        favoriteMovie.setValue(movie.voteCount, forKey: "voteCount")
        
        return context
    }
    
}
