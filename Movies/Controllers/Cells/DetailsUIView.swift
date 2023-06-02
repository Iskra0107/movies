//
//  DetailsUIView.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 3.5.23.
//

import UIKit
import SnapKit

class DetailsUIView: UIView {
    
    private var popularityLabel: UILabel!
    private var popularity: UILabel!
    private var durationLabel: UILabel!
    private var duration: UILabel!
    private var backgroundHomeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .clear
        
        backgroundHomeImageView = UIImageView()
        backgroundHomeImageView.image = UIImage(named: "blur")
        
        popularityLabel = UILabel()
        popularityLabel.text = "Popularity"
        popularityLabel.clipsToBounds = true
        popularityLabel.layer.masksToBounds = false
        popularityLabel.numberOfLines = 0
        popularityLabel.textColor = .white
        popularityLabel.layer.shadowColor = UIColor.white.cgColor
        popularityLabel.layer.shadowRadius = 7.0
        popularityLabel.layer.shadowOpacity = 1.0
        popularityLabel.layer.shadowOffset = CGSize.zero
        popularityLabel.layer.masksToBounds = false
        popularityLabel.contentMode = .scaleToFill
        popularityLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        durationLabel = UILabel()
        durationLabel.text = "123"
        durationLabel.clipsToBounds = true
        durationLabel.numberOfLines = 0
        durationLabel.textColor = .white
        durationLabel.layer.shadowColor = UIColor.white.cgColor
        durationLabel.layer.shadowRadius = 7.0
        durationLabel.layer.shadowOpacity = 1.0
        durationLabel.layer.shadowOffset = CGSize.zero
        durationLabel.layer.masksToBounds = false
        durationLabel.contentMode = .scaleToFill
        durationLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        self.addSubview(backgroundHomeImageView)
        addSubview(popularityLabel)
        addSubview(durationLabel)
    }
    
    private func setupConstraints(){
        
        backgroundHomeImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        popularityLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(popularityLabel.snp.bottom).offset(15)
            make.centerX.equalTo(popularityLabel)
        }
    }
    
    func setupView(isForPopularity: Bool , movie: Movie?) {
        popularityLabel.text = isForPopularity ? "Popularity" : "Duration"
        let popularity = String(movie?.popularity ?? 0.0)
        durationLabel.text = isForPopularity ? popularity : "130"
    }
}
