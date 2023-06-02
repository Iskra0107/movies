//
//  CategoryViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 2.5.23.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
import DropDown

class CategoryViewController: UIViewController {
    // MARK: UI Elements
    private var tableView: UITableView!
    var movieCategory: MovieCategory!
    var movies = [Movie]()
    private var backgroundHomeImageView: UIImageView!
    var currentPage = 1
    
    // MARK: DropDown Elements
    let myDropDown = DropDown()
    let filterValueArray = ["rating", "name"]
    var dropdownButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        getData(page: currentPage)
        setupNavigationButton()
        setupDropdownMenu()
        dropdownButton.isHidden = true
        removeObservers()
        addObservers()
        tableView.reloadData()
    }
    
    init(category: MovieCategory) {
        super.init(nibName: nil, bundle: nil)
        movieCategory = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: removeObservers
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .favoriteMovieChanged, object: nil)
    }
    //MARK: addObservers
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteMovieChangedNotification), name: .favoriteMovieChanged, object: nil)
    }
    
    @objc private func handleFavoriteMovieChangedNotification(_ notification: NSNotification) {
        guard let movieId = notification.userInfo?["updatedMovie"] as? Int,
              let indexPath = movies.firstIndex(where: { $0.id == movieId }),
              let cell = tableView.cellForRow(at: IndexPath(row: indexPath, section: 0)) as? HomeTableViewCell else {
            return
        }
        
        let movie = movies[indexPath]
        let isFavorited = Utilities.shared.isFavoriteMovie(movie: movie)
        
        cell.favButton.setImage(UIImage(named: isFavorited ? "heartFill" : "heart"), for: .normal)
    }
    
    //MARK: Set up Button for Filter
    func setupNavigationButton() {
        let filterBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filterMovies))
        self.navigationItem.rightBarButtonItem  = filterBarButtonItem
    }
    
    @objc func filterMovies() {
        dropdownButton.sendActions(for: .touchUpInside)
    }
    
    // MARK: - Setup Dropdown Menu
    func setupDropdownMenu() {
        dropdownButton.setTitle("Filter", for: .normal)
        dropdownButton.setTitleColor(.black, for: .normal)
        dropdownButton.backgroundColor = .white
        dropdownButton.addTarget(self, action: #selector(dropdownButtonTapped), for: .touchUpInside)
        
        myDropDown.anchorView = dropdownButton
        myDropDown.dataSource = filterValueArray
        myDropDown.bottomOffset = CGPoint(x: 0, y: dropdownButton.bounds.height)
        
        myDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropdownButton.setTitle(item, for: .normal)
            self?.clickUp() 
        }
    }
    
    @objc func dropdownButtonTapped() {
        if myDropDown.isHidden {
            myDropDown.show()
        } else {
            myDropDown.hide()
        }
    }
    
    func clickUp() {
        guard let selectedItem = myDropDown.selectedItem else {
            return
        }
        if selectedItem == "rating" {
            sortedMoviesByRating()
        } else if selectedItem == "name" {
            sortedMoviesByNames()
        }
    }
    
    //MARK: - Setup Views
    func setupViews() {
        backgroundHomeImageView = UIImageView()
        backgroundHomeImageView.image = UIImage(named: "Home")
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(backgroundHomeImageView)
        view.addSubview(tableView)
        view.addSubview(myDropDown)
        view.addSubview(dropdownButton)
    }
    
    //MARK: - Setup Constraints
    func setupConstraints(){
        backgroundHomeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view)
        }
        
        dropdownButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.right.equalTo(view).offset(-5)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Get data
    func getData(page: Int) {
        let url = handleApiUrl(category: movieCategory)
        
        AF.request(url).validate().responseDecodable(of: MovieResponse.self){ response in
            switch response.result {
            case.success(let movies):
                self.movies.append(contentsOf: movies.movies ?? [Movie]())
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                    print(self.movies.count)
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
    
    func handleApiUrl(category: MovieCategory) -> String {
        switch category {
        case .topRatedMovies:
            return String(format: Constants.Endopoints.topRatedMovies, currentPage)
        case .upcomingMovies:
            return String(format: Constants.Endopoints.upcomingMovies, currentPage)
        case .popularMovies:
            return String(format: Constants.Endopoints.popularMovies, currentPage)
        case .onTheAirShows:
            return String(format: Constants.onTheAirURL, currentPage)
        }
    }
    
    //MARK: Sorting movies by Rating
    func sortedMoviesByRating() {
        let filteredMovies = movies.filter { $0.voteAverage != nil }
        movies = filteredMovies.sorted { $0.voteAverage! > $1.voteAverage! }//podredi gi koj ima pogolem rating
        tableView.reloadData()
    }
    
    //MARK: Sorting movies by Names
    func sortedMoviesByNames() {
        movies.sort { (movie1, movie2) -> Bool in
            guard let title1 = movie1.title, let title2 = movie2.title else {
                return false
            }
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
        }
        
        tableView.reloadData()
    }
    
    
}

extension CategoryViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.setupCategories(category: movies[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count-1 {
            currentPage += 1
            getData(page: currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailscategoryVC = MovieDetailsViewController(movieId: movies[indexPath.row].id ?? 0)
        navigationController?.pushViewController(detailscategoryVC, animated: true)
    }
}
extension CategoryViewController: HomeTableViewCellDelegate{
    func favoriteButtonTapped(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        if Utilities.shared.isFavoriteMovie(movie: movie) {
            UserDefaultsManager.removeFavoriteMovie(movie: movie)
        } else {
            UserDefaultsManager.setFavoriteMovie(movie: movie)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
