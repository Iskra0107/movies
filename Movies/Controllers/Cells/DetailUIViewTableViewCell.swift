//
//  Details2CategoryTableViewCell.swift
//  Movies
//
//  Created by Iskra Gjorgjievska on 3.5.23.
//

import UIKit
import SnapKit

class DetailUIViewTableViewCell: UITableViewCell {
    
    private var popularityView: DetailsUIView!
    private var durationView: DetailsUIView!
    private var movie: Movie?
    
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
        
        popularityView = DetailsUIView()
        popularityView.setupView(isForPopularity: true, movie: movie)
        
        durationView = DetailsUIView()
        durationView.setupView(isForPopularity: false, movie: movie)
        
        contentView.addSubview(popularityView)
        contentView.addSubview(durationView)
    }
    
    private func setupConstraints(){
        popularityView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(180)
            make.width.equalTo(160)
            make.left.equalTo(contentView).offset(15)
        }
        
        durationView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(180)
            make.width.equalTo(160)
            make.right.equalTo(contentView).offset(-15)
        }
    }
    
    func setupCell(movie: Movie?) {
        popularityView.setupView(isForPopularity: true, movie: movie)
        durationView.setupView(isForPopularity: false, movie: movie)
    }
}
