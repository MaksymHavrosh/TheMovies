//
//  Movie.swift
//  TheMovies
//
//  Created by MG on 19.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import Foundation

struct Movie {
    
    let adult: Bool
    let backdropPath: String
    let genreIds: Int
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Int
    let voteAverage: Double
    let voteCount: Int
    
    init(_ dict: [String : Any]) {
        
        self.adult = dict["adult"] as? Bool ?? true
        self.backdropPath = dict["backdrop_path"] as? String ?? ""
        self.genreIds = dict["genre_ids"] as? Int ?? 0
        self.id = dict["id"] as? Int ?? 0
        self.originalLanguage = dict["original_language"] as? String ?? ""
        self.originalTitle = dict["original_title"] as? String ?? ""
        self.overview = dict["overview"] as? String ?? ""
        self.popularity = dict["popularity"] as? Double ?? 0
        self.posterPath = dict["poster_path"] as? String ?? ""
        self.releaseDate = dict["release_date"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.video = dict["video"] as? Int ?? 0
        self.voteAverage = dict["vote_average"] as? Double ?? 0
        self.voteCount = dict["vote_count"] as? Int ?? 0
    }
    
}
