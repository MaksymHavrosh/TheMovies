//
//  ServerManager.swift
//  TheMovies
//
//  Created by MG on 19.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import Foundation
import Alamofire

struct ServerManager {
    
    private static let baseURL = "https://api.themoviedb.org/3/movie/"
    private static let apiKey = "987e8b58a6ddfe9495c940f6ab2c12eb"
    private static let language = "ru-RU"
    
    static func getPopularMovies(page: Int, success: @escaping ([Movie]) -> Void) {
        
        AF.request(baseURL + "top_rated?api_key=" + apiKey + "&language=" + language + "&page=" + "\(page)",
                   method: .get,
                   encoding: URLEncoding.default).responseJSON { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        
                        guard let value = value as? [String: Any], let results = value["results"] as? [[String: Any]] else { return }
                        var movies = [Movie]()
                        
                        for movieDictionary in results {
                            let movie = Movie(movieDictionary)
                            movies.append(movie)
                        }
                        success(movies)
                        
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
    static func getVideosByMovieId(id: Int, success: @escaping ([Video]) -> Void) {
        
        AF.request(baseURL + "\(id)" + "/videos?api_key=" + apiKey + "&language=" + language,
                   method: .get,
                   encoding: URLEncoding.default).responseJSON { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        
                        guard let value = value as? [String: Any], let results = value["results"] as? [[String: Any]] else { return }
                        var videos = [Video]()
                        
                        for videoDictionary in results {
                            let video = Video(videoDictionary)
                            videos.append(video)
                        }
                        success(videos)
                        
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
}
