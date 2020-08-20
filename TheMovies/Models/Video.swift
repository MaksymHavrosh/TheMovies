//
//  Video.swift
//  TheMovies
//
//  Created by MG on 20.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit

struct Video {
    
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    init(_ dict: [String : Any]) {
        
        self.id = dict["id"] as? String ?? ""
        self.key = dict["key"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.site = dict["site"] as? String ?? ""
        self.size = dict["size"] as? Int ?? 0
        self.type = dict["type"] as? String ?? ""
    }
    
}
