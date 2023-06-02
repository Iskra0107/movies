//
//  CategoriesCollectionViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 27.4.23.
//

import UIKit
import SnapKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    private var imageViewCell: UIImageView!
    private var imageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        imageViewCell = UIImageView()
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.masksToBounds = true
        imageViewCell.layer.cornerRadius = 15
        imageViewCell.clipsToBounds = true
        imageViewCell.backgroundColor = .systemGray
        let yourColor : UIColor = UIColor(red: 0.7843, green: 0.6824, blue: 0.9647, alpha: 1.0)
        imageViewCell.layer.borderColor = yourColor.cgColor
        imageViewCell.layer.borderWidth = 3.0
        
        imageLabel = UILabel()
        imageLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        imageLabel.clipsToBounds = true
        imageLabel.textColor = .white
        imageLabel.layer.masksToBounds = false
        imageLabel.textAlignment = .center
        
        imageLabel.layer.shadowColor = UIColor.white.cgColor
        imageLabel.layer.shadowRadius = 7.0
        imageLabel.layer.shadowOpacity = 1.0
        imageLabel.layer.shadowOffset = CGSize.zero
        imageLabel.layer.masksToBounds = false
        
        contentView.addSubview(imageViewCell)
        contentView.addSubview(imageLabel)
    }
    
    private func setupConstraints() {
        imageViewCell.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        imageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageViewCell.snp.bottom).offset(-10)
            make.width.equalTo(imageViewCell.snp.width)
            make.height.equalTo(20)
        }
    }
    
    func setupCategoryCollectionCell(categoryName: String) {
        imageLabel.text = categoryName
        imageViewCell.image = UIImage(named: "categories")
        imageViewCell.contentMode = .scaleAspectFill
    }
}
