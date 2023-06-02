//
//  HomeTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 26.4.23.
//

import UIKit
import SnapKit
import Kingfisher

protocol HomeTableViewCellDelegate: AnyObject{
    func favoriteButtonTapped(indexPath: IndexPath)
}

class HomeTableViewCell: UITableViewCell {
    
    private var dayLabel: UILabel!
    private var hourLabel: UILabel!
    private var languageLabel: UILabel!
    private var genreLabel: UILabel!
    private var tVProgramLabel: UILabel!
    private var subTitleLabel: UILabel!
    private var titleLabel: UILabel!
    private var homeImageView: UIImageView!
    private var movies = [Movie]()
    var favButton: UIButton!
    private var indexPath: IndexPath?
    
    weak var delegate: HomeTableViewCellDelegate?
    
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
        tVProgramLabel.isHidden = false
        genreLabel.isHidden = false
        homeImageView.isHidden = false
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        favButton = UIButton(type: .custom)
        favButton.addTarget(self, action: #selector(handleFavourite), for: .touchUpInside)
        
        homeImageView = UIImageView()
        homeImageView.contentMode = .scaleAspectFill
        homeImageView.layer.cornerRadius = 8
        homeImageView.clipsToBounds = true
        homeImageView.layer.masksToBounds = true
        homeImageView.backgroundColor = .gray
        
        dayLabel = UILabel()
        dayLabel.numberOfLines = 0
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.backgroundColor = .purple
        dayLabel.layer.cornerRadius = 4.0
        dayLabel.layer.masksToBounds = true
        dayLabel.font = UIFont.systemFont(ofSize: 12)
        dayLabel.textColor = .white
        dayLabel.textAlignment = .center
        dayLabel.sizeToFit()
        
        hourLabel = UILabel()
        hourLabel.font = UIFont.systemFont(ofSize: 20)
        hourLabel.numberOfLines = 0
        hourLabel.backgroundColor = .systemPink
        hourLabel.layer.cornerRadius = 4
        hourLabel.layer.masksToBounds = true
        hourLabel.font = UIFont.systemFont(ofSize: 14)
        hourLabel.textColor = .white
        hourLabel.textAlignment = .center
        hourLabel.sizeToFit()
        
        languageLabel = UILabel()
        languageLabel.font = UIFont.systemFont(ofSize: 20)
        languageLabel.numberOfLines = 0
        languageLabel.backgroundColor = .lightGray
        languageLabel.layer.cornerRadius = 4
        languageLabel.layer.masksToBounds = true
        languageLabel.font = UIFont.systemFont(ofSize: 12)
        languageLabel.textColor = .white
        languageLabel.textAlignment = .center
        languageLabel.sizeToFit()
        
        genreLabel = UILabel()
        genreLabel.font = UIFont.systemFont(ofSize: 20)
        genreLabel.numberOfLines = 0
        genreLabel.backgroundColor = .systemMint
        genreLabel.layer.cornerRadius = 4
        genreLabel.layer.masksToBounds = true
        genreLabel.font = UIFont.systemFont(ofSize: 12)
        genreLabel.textColor = .white
        genreLabel.textAlignment = .center
        genreLabel.sizeToFit()
        
        tVProgramLabel = UILabel()
        tVProgramLabel.font = UIFont.systemFont(ofSize: 20)
        tVProgramLabel.numberOfLines = 0
        tVProgramLabel.backgroundColor = .systemMint
        tVProgramLabel.layer.cornerRadius = 4
        tVProgramLabel.layer.masksToBounds = true
        tVProgramLabel.font = UIFont.systemFont(ofSize: 12)
        tVProgramLabel.textColor = .white
        tVProgramLabel.textAlignment = .center
        tVProgramLabel.sizeToFit()
        
        subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 18)
        subTitleLabel.clipsToBounds = true
        subTitleLabel.textColor = .white
        subTitleLabel.layer.masksToBounds = false
        subTitleLabel.numberOfLines = 0
        subTitleLabel.layer.shadowColor = UIColor.white.cgColor
        subTitleLabel.layer.shadowRadius = 7.0
        subTitleLabel.layer.shadowOpacity = 1.0
        subTitleLabel.layer.shadowOffset = CGSize.zero
        subTitleLabel.layer.masksToBounds = false
        subTitleLabel.sizeToFit()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.clipsToBounds = true
        titleLabel.textColor = .white
        titleLabel.layer.masksToBounds = false
        titleLabel.numberOfLines = 0
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowRadius = 7.0
        titleLabel.layer.shadowOpacity = 1.0
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.masksToBounds = false
        titleLabel.sizeToFit()
        
        contentView.addSubview(homeImageView)
        contentView.addSubview(dayLabel)
        contentView.addSubview(hourLabel)
        contentView.addSubview(languageLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(tVProgramLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favButton)
    }
    
    private func setupConstraints() {
        homeImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(homeImageView.snp.top).offset(10)
            make.left.equalTo(homeImageView.snp.left).offset(10)
            make.height.equalTo(22)
        }
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(homeImageView.snp.top).offset(10)
            make.left.equalTo(dayLabel.snp.right).offset(7)
            make.height.equalTo(22)
        }
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(homeImageView.snp.top).offset(10)
            make.left.equalTo(hourLabel.snp.right).offset(7)
            make.height.equalTo(22)
        }
        tVProgramLabel.snp.makeConstraints { make in
            make.top.equalTo(homeImageView.snp.top).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.height.equalTo(22)
        }
        favButton.snp.makeConstraints { make in
            make.top.equalTo(tVProgramLabel.snp.bottom).offset(10)
            make.right.equalTo(tVProgramLabel).offset(-5)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(homeImageView.snp.top).offset(10)
            make.right.equalTo(tVProgramLabel.snp.left).offset(-8)
            make.height.equalTo(22)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(homeImageView.snp.bottom).offset(-12)
            make.left.equalTo(contentView).offset(8)
            make.height.equalTo(29)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-4)
            make.left.equalTo(titleLabel)
            make.height.equalTo(22)
        }
    }
    @objc func handleFavourite() {
        NotificationCenter.default.post(name: .favoriteMovieChanged, object: nil)
        guard let indexPath = indexPath else { return }
        delegate?.favoriteButtonTapped(indexPath: indexPath)
    }
    
    func setupHomeTableViewCell(movie: Movie) {
        dayLabel.isHidden = true
        hourLabel.isHidden = true
        languageLabel.isHidden = true
        tVProgramLabel.isHidden = true
        genreLabel.isHidden = true
        subTitleLabel.isHidden = true
        
        titleLabel.text = movie.originalName
        guard let safeImageUrl = movie.posterPath else { return }
        let ImageUrl = Constants.imageURL + safeImageUrl
        homeImageView.kf.setImage(with: URL(string: ImageUrl))
        homeImageView.contentMode = .scaleAspectFill
    }
    
    func setupCategories(category: Movie, indexPath: IndexPath){
        self.indexPath = indexPath
        
        dayLabel.text = category.releaseDate
        hourLabel.text = "08:30"
        languageLabel.text = category.originalLanguage
        favButton.setImage(UIImage(named: "heart"), for: .normal)
        favButton.setImage(UIImage(named: Utilities.shared.isFavoriteMovie(movie: category) ? "heartFill" : "heart"), for: .normal)
        
        titleLabel.text = category.title
        subTitleLabel.text = category.originalTitle
        
        if category.genreName.isEmpty {
            tVProgramLabel.isHidden = true
            genreLabel.isHidden = true
        } else if category.genreName.count == 1 {
            tVProgramLabel.text = category.genreName[0]
            genreLabel.isHidden = true
        } else {
            tVProgramLabel.text = category.genreName[0]
            genreLabel.text = category.genreName[1]
        }
        
        guard let safeImageUrl = category.backdropPath else { return }
        let ImageUrl = Constants.imageURL + safeImageUrl
        homeImageView.kf.setImage(with: URL(string: ImageUrl))
    }
}
