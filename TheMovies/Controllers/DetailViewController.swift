//
//  DetailViewController.swift
//  TheMovies
//
//  Created by MG on 20.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie?
    var videos = [Video]()
    var selectVideo: Video?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        guard let movie = movie else { return }
        nameLabel.text = movie.title
        dateLabel.text = movie.release_date
        overviewTextView.text = movie.overview
        getVideosBy(movie.id)
        
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

//MARK: - Private

private extension DetailViewController {
    
    func getVideosBy(_ movieID: Int) {
        
        ServerManager.getVideosByMovieId(id: movieID, success: { videos in
            self.videos.append(contentsOf: videos)
            self.tableView.reloadData()
        })
    }
    
}
