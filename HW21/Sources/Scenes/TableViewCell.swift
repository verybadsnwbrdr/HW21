//
//  TableViewCell.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "TableViewCell"
    
    // MARK: - Properties
    
    var cellModel: CellModel? {
        didSet {
            nameLabel.text = cellModel?.name // Приходит nil
            idLabel.text = String(cellModel?.id ?? 0)
//            guard let data = cellModel?.image,
//                  let image = UIImage(data: data) else { return }
//            characterImage.image = image
        }
    }
    
    // MARK: - Elements
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(nameLabel)
        addSubview(idLabel)
        addSubview(characterImage)
    }
    
    private func setupLayout() {
        characterImage.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(characterImage.snp.right).offset(20)
            make.top.equalTo(snp.top).offset(20)
        }
        
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
}
