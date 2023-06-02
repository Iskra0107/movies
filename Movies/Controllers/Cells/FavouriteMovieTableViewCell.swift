//
//  FavouriteMovieTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 11.5.23.
//

import UIKit
import SnapKit


//
//  FavouriteMovieTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 11.5.23.
//

import UIKit
import SnapKit

protocol FavouFavouriteMovieTableViewCellDelegate: AnyObject{
    func favoriteButtonUntapped(indexPath: IndexPath, movieId: Int)
}
class FavouriteMovieTableViewCell: UITableViewCell{
    
    private var genreNameLabel: UILabel!
    private var collectionView: UICollectionView!
    var movies = [Movie]()
    private var moviesByGenre: (Genre, [Movie])?
    
    //MARK: Delegate
    weak var delegate: FavouFavouriteMovieTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        collectionView.reloadData()
        
        //MARK: Add and remove Observers
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("favoriteMovieChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteMovieChanged(_:)), name: NSNotification.Name("favoriteMovieChanged"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleFavoriteMovieChanged(_ notification: Notification) {
        collectionView.reloadData()
    }
    
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        genreNameLabel = UILabel()
        genreNameLabel.numberOfLines = 0
        genreNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        genreNameLabel.clipsToBounds = true
        genreNameLabel.textColor = .white
        genreNameLabel.layer.masksToBounds = false
        genreNameLabel.textAlignment = .center
        
        genreNameLabel.layer.shadowColor = UIColor.white.cgColor
        genreNameLabel.layer.shadowRadius = 7.0
        genreNameLabel.layer.shadowOpacity = 1.0
        genreNameLabel.layer.shadowOffset = CGSize.zero
        genreNameLabel.layer.masksToBounds = false
        let yourColor : UIColor = UIColor(red: 0.7843, green: 0.6824, blue: 0.9647, alpha: 1.0)
        genreNameLabel.layer.borderColor = yourColor.cgColor
        genreNameLabel.layer.borderWidth = 3.0
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(FavouriteMovieCollectionViewCell.self, forCellWithReuseIdentifier: "favouriteMovieCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        contentView.addSubview(genreNameLabel)
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        genreNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(genreNameLabel.snp.bottom).offset(7)
            make.left.equalTo(genreNameLabel)
            make.right.equalTo(genreNameLabel)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    func setupCell(genreName: String, genreMovies: (Genre, [Movie])) {
        genreNameLabel.text = genreName
        moviesByGenre = genreMovies
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension FavouriteMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 //samo edna sekcija, vnatre povekje rows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesByGenre?.1.count ?? 0 //pristapuvam do broj na filmovi od momentalen zanr
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteMovieCollectionViewCell", for: indexPath) as! FavouriteMovieCollectionViewCell
        if let movie = moviesByGenre?.1[indexPath.row], let movieId = moviesByGenre?.0.id {
            cell.setUpCell(movie: movie, indexPath: indexPath, movieId: movie.id ?? 0)
            cell.delegate = self
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension FavouriteMovieTableViewCell: FavouriteMovieCollectionViewCellDelegate {
    func favoriteButtonUntapped(indexPath: IndexPath, movieId: Int) {
        delegate?.favoriteButtonUntapped(indexPath: indexPath, movieId: movieId)
    }
}



