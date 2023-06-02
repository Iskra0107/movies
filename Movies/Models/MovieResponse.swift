//
//  Category.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 2.5.23.
//

import Foundation

// MARK: - Welcome
struct MovieResponse: Codable {
    let dates: Date?
    let page: Int?
    let movies: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Date: Codable {
    let maximum, minimum: String?
}

// MARK: - Category
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genreIDS: [Int]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genreIDS = "genre_ids"
        case homepage
        case id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        
    }
    
    var genreName: [String] {
        return handleGenreName()
    }
    
    func handleGenreName() -> [String] {
        var genreNames = [String]()
        
        guard let safeGenreId = genreIDS else { return [""] }
        let safeGenreData = DataModel.shared.allGenres
        for genreId in safeGenreId {
            for genreData in safeGenreData {
                if genreData.id == genreId {
                    if let name = genreData.name {
                        genreNames.append(name)
                    }
                    break
                }
            }
        }
        return genreNames
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable{
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry:Codable {
    let iso3166_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage:Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
