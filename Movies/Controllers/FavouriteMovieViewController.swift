//
//  FavouriteMovieViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 11.5.23.
//

import UIKit
import SnapKit

class FavouriteMovieViewController: UIViewController {
    // MARK: UI Elements
    private var tableView: UITableView!
    private var backgroundHomeImageView: UIImageView!
    private var movies = [Movie]() //niza od filmovi
    
    // MARK: Data
    private var moviesByGenre: [(Genre, [Movie])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    @objc private func handleFavoriteMovieChangedNotification() {
        handleNumberOfSections()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNumberOfSections()
        tableView.reloadData()
    }
    
    func setupViews(){
        backgroundHomeImageView = UIImageView()
        backgroundHomeImageView.image = UIImage(named: "Home")
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteMovieTableViewCell.self, forCellReuseIdentifier: "favouriteMovieTableViewCell")
        
        view.addSubview(backgroundHomeImageView)
        view.addSubview(tableView)
    }
    
    func setupConstraints(){
        backgroundHomeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
            make.bottom.equalTo(view)
        }
    }
    
    //MARK: handleNumberofSection
    func handleNumberOfSections() {
        moviesByGenre.removeAll()                                                                   //prebirshi gi , koa pravis append pravi removeAll
        let movies = UserDefaultsManager.getFavoriteMovies()                                        //movies - get all movies
        for genre in DataModel.shared.allGenres {                                                   //genre - all genres
            let moviesForGenre = movies.filter { $0.genreIDS?.contains(genre.id ?? 0) ?? false }    //vo movieForGenre - filtriraj zhanr spored id
            if !moviesForGenre.isEmpty {                                                            //vo movieForGenre - ako ne e prazno napravi torki
                let genreTuple = (genre, moviesForGenre)                                            //vo genreTuple - (zhanr, filmovi)
                moviesByGenre.append(genreTuple)                                                    //zalepi gi torkite na moviesByGenre: [(Genre, [Movie])] kaj so                                                                                   se site torki
            }
        }
        print(moviesByGenre.count)
    }
    
}

extension FavouriteMovieViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesByGenre.count //izbroj gi torkite
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteMovieTableViewCell", for: indexPath) as! FavouriteMovieTableViewCell
        let genreTuple = moviesByGenre[indexPath.section]  //torki po sekcija
        cell.setupCell(genreName: genreTuple.0.name ?? "", genreMovies: genreTuple) //zemi name od 0tata , torki
        cell.delegate = self // set the delegate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}


extension FavouriteMovieViewController: FavouFavouriteMovieTableViewCellDelegate {
    
    func favoriteButtonUntapped(indexPath: IndexPath, movieId: Int) { //dodaj id na filmovi
        let movie = UserDefaultsManager.getFavoriteMovies().filter({ currentMovie in //filtriraj spored id
            currentMovie.id == movieId
        })
        if let favoriteMovie = movie.first { //movie e niza, pa stavame first za da nema error no i za da go zeme prviot samo eden ima
            UserDefaultsManager.removeFavoriteMovie(movie: favoriteMovie) //izbrishi go toj so e fav , zemen od movie.first , vo movie.first ni e current
            
            //MARK: Post notification
            NotificationCenter.default.post(name: .favoriteMovieChanged, object: nil, userInfo: ["updatedMovie": movie.first?.id ?? 0])
        }
        handleNumberOfSections()
        tableView.reloadData()
    }
}
