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
    
    private static let baseURL = "https://api.themoviedb.org/3/"
    private static let apiKey = "987e8b58a6ddfe9495c940f6ab2c12eb"
    
    static func getPopularMovies(page: Int, success: @escaping ([Movie]) -> Void) {
        
        AF.request(baseURL + "movie/top_rated?api_key=" + apiKey + "&page=" + "\(page)",
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
    
}
