//
//  HomeViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 24.4.23.
//

import UIKit
import SnapKit
import Alamofire

class HomeViewController: UIViewController {
    private var backgroundHomeImageView: UIImageView!
    var tableView: UITableView!
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        getDetailDataAiringToday()
    }
    private func setupViews(){
        backgroundHomeImageView = UIImageView()
        backgroundHomeImageView.image = UIImage(named: "Home")
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "categoriesTableViewCell")
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeTableViewCell")
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderTopPadding = 0
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(backgroundHomeImageView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        backgroundHomeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view)
        }
    }
    
    private func getDetailDataAiringToday() {
        MovieService.fetchAiringToday(){ result in
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
            cell.setupHomeTableViewCell(movie: movies[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(headerView).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        if section == 0 {
            titleLabel.text = "Categories"
        } else {
            titleLabel.text = "Airing Today Series"
        }
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            return 206
        }
    }
}

extension HomeViewController: CategoriesCollectionViewCellDelegate {
    func pushContoller(indexPathRow: Int) {
        let categoryVC = CategoryViewController(category: handleCategories(indexPathRow: indexPathRow))
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    func handleCategories(indexPathRow: Int) -> MovieCategory {
        if indexPathRow == 0 {
            return .topRatedMovies
        } else if indexPathRow == 1 {
            return .upcomingMovies
        } else if indexPathRow == 2 {
            return .popularMovies
        } else {
            return .onTheAirShows
        }
    }
}

extension HomeViewController: HomeTableViewCellDelegate{
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
