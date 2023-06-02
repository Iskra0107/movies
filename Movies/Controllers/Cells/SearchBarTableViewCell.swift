//
//  SearchBarTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 8.5.23.
//

import UIKit
import SnapKit
import Kingfisher

protocol SearchBarTableViewCellDelegate: AnyObject{
    func favoriteButtonTapped(indexPath: IndexPath)
}
class SearchBarTableViewCell: UITableViewCell {
    
    private var movieImageView: UIImageView!
    private var titleLabel: UILabel!
    private var ratingLabel: UILabel!
    private var stackView: UIStackView!
    private var ratingImageView: UIImageView!
    private var genreImageView: UIImageView!
    var favButton: UIButton!
    private var indexPath: IndexPath?
    
    weak var delegate: SearchBarTableViewCellDelegate?
    
    private var movie1: Movie!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
        //MARK: Add and remove Observers
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.favoriteMovieChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteMovieChanged(_:)), name: NSNotification.Name.favoriteMovieChanged, object: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func handleFavoriteMovieChanged(_ notification: Notification) {
        print("hello")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        genreImageView.isHidden = false
        ratingImageView.isHidden = false
        stackView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func setupViews(){
        backgroundColor = .clear
        selectionStyle = .none
        
        favButton = UIButton(type: .custom)
        favButton.setImage(UIImage(named: "heart"), for: .normal)
        favButton.addTarget(self, action: #selector(handleFavourite), for: .touchUpInside)
        
        movieImageView = UIImageView()
        movieImageView.clipsToBounds = true
        movieImageView.layer.masksToBounds = true
        let yourColor : UIColor = UIColor(red: 0.7843, green: 0.6824, blue: 0.9647, alpha: 1.0)
        movieImageView.layer.borderColor = yourColor.cgColor
        movieImageView.layer.borderWidth = 3.0
        movieImageView.contentMode = .scaleAspectFill
        
        titleLabel = UILabel()
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowRadius = 7.0
        titleLabel.layer.shadowOpacity = 1.0
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.masksToBounds = false
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        ratingLabel = UILabel()
        ratingLabel.clipsToBounds = true
        ratingLabel.textColor = .white
        ratingLabel.sizeToFit()
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        
        ratingImageView = UIImageView()
        ratingImageView.image = UIImage(named: "ratings")
        ratingImageView.clipsToBounds = true
        ratingImageView.layer.masksToBounds = true
        
        genreImageView = UIImageView()
        genreImageView.image = UIImage(named: "genres")
        genreImageView.clipsToBounds = true
        genreImageView.layer.masksToBounds = true
        
        contentView.addSubview(favButton)
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(ratingImageView)
        contentView.addSubview(genreImageView)
    }
    private func setupConstraints(){
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(180)
        }
        favButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(movieImageView.snp.right).offset(15)
            make.right.equalTo(favButton.snp.left).offset(-5)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(15)
            make.width.height.equalTo(25)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(ratingImageView.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
        genreImageView.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(15)
            make.width.height.equalTo(25)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(genreImageView)
            make.left.equalTo(genreImageView.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
        
    }

    @objc func handleFavourite() {
        guard let indexPath = indexPath else { return }
        delegate?.favoriteButtonTapped(indexPath: indexPath)
        
        NotificationCenter.default.post(name: .favoriteMovieChanged, object: nil)
    }
    
    func setupCell(movie: Movie?, indexPath: IndexPath){
        self.movie1 = movie
        self.indexPath = indexPath
        
        favButton.setImage(UIImage(named: Utilities.shared.isFavoriteMovie(movie: movie1) ? "heartFill" : "heart"), for: .normal)
        
        if let safeImageUrl = movie1.backdropPath {
            let ImageUrl = Constants.imageURL + safeImageUrl
            movieImageView.kf.setImage(with: URL(string: ImageUrl))
        } else {
            movieImageView.image = UIImage(named: "categories")
        }
        
        titleLabel.text = movie1.title
        ratingLabel.text = String(movie1.voteAverage ?? 0.0)
        
        if let ratingText = ratingLabel.text, ratingText.isEmpty {
            ratingImageView.isHidden = true
        } else {
            ratingImageView.isHidden = false
        }
        
        let movieGenresCount = movie1.genreIDS?.count ?? 0
        if movieGenresCount != 0 {
            genreImageView.isHidden = false
            stackView.subviews.forEach({ $0.removeFromSuperview() })
            for i in 0..<movieGenresCount {
                let genreName = getGenreName(genreID: movie1.genreIDS![i])
                let genreLabel = UILabel()
                genreLabel.textColor = .white
                genreLabel.text = genreName
                genreLabel.backgroundColor = UIColor.random()
                genreLabel.layer.cornerRadius = 3.0
                genreLabel.layer.masksToBounds = true
                stackView.addArrangedSubview(genreLabel)
            }
        } else {
            genreImageView.isHidden = true
        }
    }
    
    func getGenreName(genreID: Int) -> String {
        if let genre = DataModel.shared.allGenres.first(where: { $0.id == genreID }) {
            return genre.name ?? ""
        } else {
            return "Unknown"
        }
    }
}

//MARK: - extension UIColor for Random color
extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
