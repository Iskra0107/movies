//
//  MoviesServices.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 5.5.23.
//

import Foundation
import Alamofire

struct MovieService{
    // MARK: -  fetchMoviesService
    static func fetchMovie(movieId: Int, completion: @escaping (Result<Movie, AFError>) -> Void) {
        let urlString = String(format: Constants.detailsMovieURL, movieId)
        guard let url = URL(string: urlString) else {
            completion(.failure(AFError.invalidURL(url: urlString)))
            return
        }
        AF.request(url).validate().responseDecodable(of: Movie.self) { (response) in
            completion(response.result)
        }
    }
    // MARK: -  fetchMoviesSearch
    static func fetchMoviesSearch(forSearchedString searchedString: String, completion: @escaping (Result<MovieResponse, AFError>) -> Void){
        let urlString = String(format: Constants.searchMovie, searchedString)
        guard let url = URL(string:  urlString) else{
            completion(.failure(AFError.invalidURL(url: urlString)))
            return
        }
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { (response) in
            completion(response.result)
        }
    }
    
    // MARK: -  fetchAiringToday
    static func fetchAiringToday(completion: @escaping (Result<MovieResponse, AFError>) -> Void){
        let urlString = String(format: Constants.airingToday)
        guard let url = URL(string:  urlString) else{
            completion(.failure(AFError.invalidURL(url: urlString)))
            return
        }
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { (response) in
            completion(response.result)
        }
    }
    
}
