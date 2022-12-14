//
//  TableViewCell.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell, FetchImageProtocol, ShowAlertProtocol {
    
    // MARK: - Identifier
    
    static let identifier = "TableViewCell"
    
    // MARK: - SetupCell
    
    func setupCellContent(with characterModel: Character) {
        nameLabel.text = characterModel.name
        idLabel.text = "ID: " + String(characterModel.id)
        fetchCharacterImage(from: characterModel.thumbnail) { [unowned self] response in
            guard let data = response.data else {
                showAlert(error: response.error)
                return
            }
            characterImage.image = UIImage(data: data)
        }
    }
    
    // MARK: - Elements
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35
        imageView.image = UIImage(named: "question")
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        idLabel.text = nil
        characterImage.image = UIImage(named: "question")
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
            make.width.height.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(characterImage.snp.right).offset(20)
            make.top.equalTo(snp.top).offset(20)
        }
        
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(snp.bottom).offset(-15)
        }
    }
}
