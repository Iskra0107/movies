//
//  Utilities.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 10.5.23.
//

import Foundation

struct Utilities {
    
    static let shared = Utilities()
    
    func isFavoriteMovie(movie: Movie) -> Bool {
        let favoriteMovies = UserDefaultsManager.getFavoriteMovies()
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
}
