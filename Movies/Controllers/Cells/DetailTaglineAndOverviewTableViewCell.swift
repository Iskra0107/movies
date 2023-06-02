//
//  Detail3CategoryTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 5.5.23.
//

import UIKit
import SnapKit

class DetailTaglineAndOverviewTableViewCell: UITableViewCell {
    
    private var taglineLabel: UILabel!
    private var overviewLabel: UILabel!
    
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
        
        let yourColor : UIColor = UIColor(red: 0.7843, green: 0.6824, blue: 0.9647, alpha: 1.0)
        
        taglineLabel = UILabel()
        taglineLabel.numberOfLines = 2
        taglineLabel.backgroundColor  = .clear
        taglineLabel.adjustsFontSizeToFitWidth = true
        taglineLabel.layer.cornerRadius = 5.0
        taglineLabel.clipsToBounds = true
        taglineLabel.textColor = .white
        
        taglineLabel.layer.borderColor = yourColor.cgColor
        taglineLabel.layer.borderWidth = 1.0
        
        overviewLabel = UILabel()
        overviewLabel.backgroundColor = .clear
        overviewLabel.numberOfLines = 0
        overviewLabel.adjustsFontSizeToFitWidth = true
        overviewLabel.layer.cornerRadius = 3.0
        overviewLabel.clipsToBounds = true
        overviewLabel.textColor = .white
        overviewLabel.layer.borderColor = yourColor.cgColor
        overviewLabel.layer.borderWidth = 1.0
        
        contentView.addSubview(taglineLabel)
        contentView.addSubview(overviewLabel)
    }
    
    private func setupConstraints(){
        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom).offset(20)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
    }
    
    func setupCell(movie: Movie?){
        taglineLabel.text = movie?.tagline
        overviewLabel.text = movie?.overview
    }
}
