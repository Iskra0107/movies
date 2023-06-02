//
//  Constants.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 2.5.23.
//

import Foundation

struct Constants {
    
    let movies = [Movie]()
    
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let onTheAirURL = "https://api.themoviedb.org/3/tv/on_the_air?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US&page=%d"
    static let imageURL = "https://image.tmdb.org/t/p/w500/"
    static let detailsMovieURL = "https://api.themoviedb.org/3/movie/%d?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US"
    static let searchMovie = "https://api.themoviedb.org/3/search/movie?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US&query=%@"
    static let airingToday = "https://api.themoviedb.org/3/tv/airing_today?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US&page=1"
    
    struct Endopoints {
        static let popularMovies = baseURL + "/popular?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US&page=%d"
     
        static let upcomingMovies = baseURL + "/upcoming?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US&page=%d"
       
        static let topRatedMovies = baseURL + "/top_rated?api_key=49e2af181d0494c31ab484f6e761a60c&language=en-US&page=%d"
        
        static let imageUrl = imageURL

    }
}
