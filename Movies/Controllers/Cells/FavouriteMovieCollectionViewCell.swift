//
//  FavouriteMovieCollectionViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 11.5.23.
//

import UIKit


protocol FavouriteMovieCollectionViewCellDelegate: AnyObject{
    func favoriteButtonUntapped(indexPath: IndexPath, movieId: Int)
}
class FavouriteMovieCollectionViewCell: UICollectionViewCell {
    
    private var favouriteMovieImageView: UIImageView!
    private var favButton: UIButton!
    private var indexPath: IndexPath?
    private var movieId: Int?
    
    //MARK: Delegate to previous Cell
    weak var delegate: FavouriteMovieCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favouriteMovieImageView.isHidden = false
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        favouriteMovieImageView = UIImageView()
        favouriteMovieImageView.clipsToBounds = true
        favouriteMovieImageView.layer.masksToBounds = true
        favouriteMovieImageView.layer.cornerRadius = 15
        favouriteMovieImageView.clipsToBounds = true
        favouriteMovieImageView.backgroundColor = .systemGray
        let yourColor : UIColor = UIColor(red: 0.7843, green: 0.6824, blue: 0.9647, alpha: 1.0)
        favouriteMovieImageView.layer.borderColor = yourColor.cgColor
        favouriteMovieImageView.layer.borderWidth = 3.0
        
        favButton = UIButton(type: .custom)
        favButton.setImage(UIImage(named: "heartFill"), for: .normal)
        favButton.addTarget(self, action: #selector(handleFavourite), for: .touchUpInside)
        
        contentView.addSubview(favouriteMovieImageView)
        contentView.addSubview(favButton)
        
    }
    private func setupConstraints() {
        favouriteMovieImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        favButton.snp.makeConstraints { make in
            make.top.equalTo(favouriteMovieImageView.snp.top).offset(10)
            make.right.equalTo(favouriteMovieImageView.snp.right).offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    @objc func handleFavourite() {
           guard let indexPath = indexPath, let movieId = movieId else { return }
           favButton.setImage(UIImage(named: "heart"), for: .normal)
           delegate?.favoriteButtonUntapped(indexPath: indexPath, movieId: movieId)
       }
    
    func setUpCell(movie: Movie, indexPath: IndexPath, movieId: Int) {
        self.movieId = movie.id
        self.indexPath = indexPath
        
        guard let safeImageUrl = movie.backdropPath else {return}
        let ImageUrl = Constants.imageURL + safeImageUrl
        favouriteMovieImageView.kf.setImage(with: URL(string: ImageUrl))
        favouriteMovieImageView.contentMode = .scaleToFill
        
        favButton.setImage(UIImage(named: Utilities.shared.isFavoriteMovie(movie: movie) ? "heartFill" : "heart"), for: .normal)

    }
}
