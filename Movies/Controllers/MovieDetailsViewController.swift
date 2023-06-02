//
//  DetailsCategoryViewController.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 3.5.23.
//

import UIKit
import SnapKit
import Alamofire

class MovieDetailsViewController: UIViewController {
    
    var movie: Movie?
    var movieId: Int!
    var backgroundHomeImageView: UIImageView!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupViews()
        setupConstrains()
        getDetailData()
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundHomeImageView = UIImageView()
        backgroundHomeImageView.image = UIImage(named: "Home")
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(DetailImageAndTitleTableViewCell.self, forCellReuseIdentifier: "detailImageAndTitleCell")
        tableView.register(DetailUIViewTableViewCell.self, forCellReuseIdentifier: "detailUIViewCell")
        tableView.register(DetailTaglineAndOverviewTableViewCell.self, forCellReuseIdentifier: "detailTaglineAndOvwervireCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(backgroundHomeImageView)
        view.addSubview(tableView)
        
    }
    func setupConstrains(){
        backgroundHomeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view).offset(0)
        }
    }
    
    func getDetailData() {
        MovieService.fetchMovie(movieId: movieId) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailImageAndTitleCell", for: indexPath) as! DetailImageAndTitleTableViewCell
            cell.setupCell(movie: movie)
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailUIViewCell", for: indexPath) as! DetailUIViewTableViewCell
            cell.setupCell(movie: movie)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailTaglineAndOvwervireCell", for: indexPath) as! DetailTaglineAndOverviewTableViewCell
            cell.setupCell(movie: movie)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 270
        } else if indexPath.row == 1 {
            return 250
        } else {
            return UITableView.automaticDimension
        }
    }
}

