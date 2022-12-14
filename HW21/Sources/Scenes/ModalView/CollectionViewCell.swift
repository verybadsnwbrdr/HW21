//
//  CollectionViewCell.swift
//  HW21
//
//  Created by Anton on 10.11.2022.
//

import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell, FetchImageProtocol, ShowAlertProtocol {
    
    // MARK: - Identifier
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - SetupCell
    
    func setupCellContent(with comicModel: Comic) {
        comicsTitle.text = comicModel.title
        fetchCharacterImage(from: comicModel.thumbnail) {  [unowned self] response in
            guard let data = response.data else {
                showAlert(error: response.error)
                return
            }
            comicsImage.image = UIImage(data: data)
        }
    }
    
    // MARK: - Elements
    
    private lazy var comicsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "question")
        return imageView
    }()
    
    private lazy var comicsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.text = "Название комикса \n"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicsImage.image = UIImage(named: "question")
        comicsTitle.text = nil
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(comicsTitle)
        addSubview(comicsImage)
        
    }
    
    private func setupLayout() {
        comicsImage.snp.makeConstraints { make in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(snp.bottom).offset(-34)
        }
        
        comicsTitle.snp.makeConstraints { make in
            make.top.equalTo(comicsImage.snp.bottom).offset(5)
            make.left.right.equalTo(self)
        }
    }
}
