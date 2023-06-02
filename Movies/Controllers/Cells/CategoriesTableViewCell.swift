import UIKit
import SnapKit


protocol CategoriesCollectionViewCellDelegate: AnyObject {
    func pushContoller(indexPathRow: Int)
}

class CategoriesTableViewCell: UITableViewCell{
    
    private var collectionView: UICollectionView!
    private var backgroundCategoriesImageView: UIImageView!
    private var categoryNamesArray = ["Top Rated", "Upcoming Movies", "Popular Movies", "On the Air Show"]
    weak var delegate: CategoriesCollectionViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        backgroundCategoriesImageView = UIImageView()
        backgroundCategoriesImageView.image = UIImage(named: "categoriesBackground")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "categoriesCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundView = backgroundCategoriesImageView
        
        contentView.addSubview(collectionView)
        contentView.addSubview(backgroundCategoriesImageView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundCategoriesImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.setupCategoryCollectionCell(categoryName: categoryNamesArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushContoller(indexPathRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 163, height: 205)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
