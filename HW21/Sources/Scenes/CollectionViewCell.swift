//
//  CollectionViewCell.swift
//  HW21
//
//  Created by Anton on 10.11.2022.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell, FetchImageProtocol {
    
    // MARK: - Identifier
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - SetupCell
    
    func setupCellContent(with model: Comic) {
        comicsTitle.text = model.title
//        fetchCharacterImage(from: model) { [unowned self] dataImage in
//            comicsImage.image = UIImage(data: dataImage)
//        }
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
        label.text = "Название комикса"
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
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(comicsTitle)
        addSubview(comicsImage)

    }
    
    private func setupLayout() {
        comicsTitle.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.left.right.equalTo(self)
        }
        
        comicsImage.snp.makeConstraints { make in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(comicsTitle.snp.top).offset(-2)
        }
    }
    
//    private func fetchComics() {
//        let stringURL = CharacterURL().getStringURL(with: <#T##String#>)
//        let request = AF.request(stringURL)
//        request.responseDecodable(of: CharacterDataWrapper.self) { data in
//            guard let char = data.value else { return }
//            let data = char.data.results
//            self.characters = data
//            self.tableView.reloadData()
//        }
//    }
}
