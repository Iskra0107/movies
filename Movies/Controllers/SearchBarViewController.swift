//
//  SearchBarViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 8.5.23.
//

import UIKit
import SnapKit
import Alamofire

class SearchBarViewController: UIViewController {
    
    private var searchController: UISearchController!
    private var tableView: UITableView!
    private var backgroundHomeImageView: UIImageView!
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        removeObservers()
        addObservers()
        view.backgroundColor = .purple
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .favoriteMovieChanged, object: nil)
    }

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteMovieChangedNotification), name: .favoriteMovieChanged, object: nil)
    }
    
    
    @objc private func handleFavoriteMovieChangedNotification(_ notification: NSNotification) {
        guard let movieId = notification.userInfo?["updatedMovie"] as? Int,
              let indexPath = movies.firstIndex(where: { $0.id == movieId }),
              let cell = tableView.cellForRow(at: IndexPath(row: indexPath, section: 0)) as? SearchBarTableViewCell else {
            return
        }

        let movie = movies[indexPath]
        let isFavorited = Utilities.shared.isFavoriteMovie(movie: movie)

        if let favoriteButton = cell.favButton {
            if isFavorited {
                favoriteButton.setImage(UIImage(named: "heartFill") , for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }

    private func setupViews(){
        backgroundHomeImageView = UIImageView()
        backgroundHomeImageView.image = UIImage(named: "Home")
        
        tableView = UITableView()
        tableView.register(SearchBarTableViewCell.self, forCellReuseIdentifier: "searchBarTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        searchBar()
        
        view.addSubview(backgroundHomeImageView)
        view.addSubview(tableView)
    }
    
    func searchBar(){
        searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
    }
    
    private func setupConstraints(){
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
    
    func fetchMoviesSearch(with name: String?){
        guard let searchedString = name else {return}
        MovieService.fetchMoviesSearch(forSearchedString: searchedString){ result in
            switch result {
            case .success(let movies):
                if let safeMovie = movies.movies {
                    self.movies = safeMovie
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchBarTableViewCell", for: indexPath) as! SearchBarTableViewCell
        cell.setupCell(movie: movies[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

//MARK: - UISearchBarDelegate methods
extension SearchBarViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        fetchMoviesSearch(with: searchBar.text)
    }
}

extension SearchBarViewController: SearchBarTableViewCellDelegate{
    func favoriteButtonTapped(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        if UserDefaultsManager.getFavoriteMovies().contains(where: { $0.id == movie.id }) {
            UserDefaultsManager.removeFavoriteMovie(movie: movie)
        } else {
            UserDefaultsManager.setFavoriteMovie(movie: movie)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
