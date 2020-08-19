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
    let backdrop_path: String
    let genre_ids: Int
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let video: Int
    let vote_average: Double
    let vote_count: Int
    
    init(_ dict: [String : Any]) {
        
        self.adult = dict["adult"] as? Bool ?? true
        self.backdrop_path = dict["backdrop_path"] as? String ?? ""
        self.genre_ids = dict["genre_ids"] as? Int ?? 0
        self.id = dict["id"] as? Int ?? 0
        self.original_language = dict["original_language"] as? String ?? ""
        self.original_title = dict["original_title"] as? String ?? ""
        self.overview = dict["overview"] as? String ?? ""
        self.popularity = dict["popularity"] as? Double ?? 0
        self.poster_path = dict["poster_path"] as? String ?? ""
        self.release_date = dict["release_date"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.video = dict["video"] as? Int ?? 0
        self.vote_average = dict["vote_average"] as? Double ?? 0
        self.vote_count = dict["vote_count"] as? Int ?? 0
    }
    
}
