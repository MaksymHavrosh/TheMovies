//
//  FavotiteMoviesTableViewController.swift
//  TheMovies
//
//  Created by MG on 20.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit
import CoreData

class FavotiteMoviesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var favoriteMovies = [FavoriteMovie]()
    private var selectedMovie: FavoriteMovie?
    
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let description = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: persistentContainer.viewContext)
        fetchRequest.entity = description
        
        let titleDescriptor = NSSortDescriptor.init(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [titleDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController.init(fetchRequest: fetchRequest,
                                                                        managedObjectContext: self.persistentContainer.viewContext,
                                                                        sectionNameKeyPath: nil,
                                                                        cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    //MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        _fetchedResultsController = nil
        favoriteMovies = []
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = fetchedResultsController.object(at: indexPath) as! FavoriteMovie
        favoriteMovies.append(movie)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath)
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController {
            vc.movie = selectedMovie
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TheMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

}

//MARK: - UITableViewDelegate

extension FavotiteMoviesTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMovie = favoriteMovies[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
}
