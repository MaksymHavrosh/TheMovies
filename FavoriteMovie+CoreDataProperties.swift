//
//  FavoriteMovie+CoreDataProperties.swift
//  TheMovies
//
//  Created by MG on 20.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIds: Int64
    @NSManaged public var id: Int64
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Int64
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int64

}
