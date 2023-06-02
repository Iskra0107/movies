//
//  DetailsCategoryTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 3.5.23.
//

import UIKit
import SnapKit

class DetailImageAndTitleTableViewCell: UITableViewCell{
    
    private var movieDetailsImage: UIImageView!
    private var movieDetailsLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .clear
        selectionStyle = .none
        
        movieDetailsImage = UIImageView()
        movieDetailsImage.clipsToBounds = true
        movieDetailsImage.layer.masksToBounds = true
        movieDetailsImage.layer.cornerRadius = 15
        movieDetailsImage.backgroundColor = .systemGray
        let yourColor : UIColor = UIColor(red: 0.7843, green: 0.6824, blue: 0.9647, alpha: 1.0)
        movieDetailsImage.layer.borderColor = yourColor.cgColor
        movieDetailsImage.layer.borderWidth = 3.0
        movieDetailsImage.image = UIImage(named: "cabinetOfCuriosities")
        
        movieDetailsLabel = UILabel()
        movieDetailsLabel.clipsToBounds = true
        movieDetailsLabel.textAlignment = .center
        movieDetailsLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        movieDetailsLabel.textColor = .white
        
        movieDetailsLabel.layer.shadowColor = UIColor.white.cgColor
        movieDetailsLabel.layer.shadowRadius = 7.0
        movieDetailsLabel.layer.shadowOpacity = 1.0
        movieDetailsLabel.layer.shadowOffset = CGSize.zero
        movieDetailsLabel.layer.masksToBounds = false
        movieDetailsLabel.text = "Title"
        
        contentView.addSubview(movieDetailsImage)
        contentView.addSubview(movieDetailsLabel)
    }
    
    private func setupConstraints(){
        movieDetailsImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.width.equalTo(contentView)
            make.height.equalTo(210)
        }
        movieDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(movieDetailsImage.snp.bottom).offset(10)
            make.width.equalTo(movieDetailsImage)
            make.height.equalTo(20)
        }
    }
    
    func setupCell(movie: Movie?){
        guard let safeImageUrl = movie?.backdropPath else {return}
        let ImageUrl = Constants.imageURL + safeImageUrl
        movieDetailsImage.kf.setImage(with: URL(string: ImageUrl))
        movieDetailsLabel.text = movie?.title
    }
}

