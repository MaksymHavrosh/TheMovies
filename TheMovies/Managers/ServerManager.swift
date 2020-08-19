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
    
    static func getPopularMovies(success: @escaping ([Any]) -> Void) {
        
        AF.request(baseURL + "movie/top_rated?api_key=" + apiKey,
                   method: .get,
                   encoding: URLEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        
                        print(value)
                        
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
}
