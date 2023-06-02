//
//  UserDefaultsManager.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 10.5.23.
//

import Foundation

class UserDefaultsManager {
    static func setFavoriteMovie(movie: Movie) {
        var moviesArray = getFavoriteMovies()
        moviesArray.append(movie)
        
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(moviesArray)
        UserDefaults.standard.set(encodedData, forKey: "FavoriteMovies")
    }
    
    static func getFavoriteMovies() -> [Movie] {
        if let safeMovies = UserDefaults.standard.object(forKey: "FavoriteMovies") as? Data {
            let decoder = JSONDecoder()
            if let movies = try? decoder.decode([Movie].self, from: safeMovies) {
                return movies
            }
        }
        return [Movie]()
    }
    
    static func removeFavoriteMovie(movie: Movie) {
        var moviesArray = getFavoriteMovies()
        if let index = moviesArray.firstIndex(where: { $0.id == movie.id }) {
            moviesArray.remove(at: index)
        }
       
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(moviesArray)
        UserDefaults.standard.set(encodedData, forKey: "FavoriteMovies")
    }
}
