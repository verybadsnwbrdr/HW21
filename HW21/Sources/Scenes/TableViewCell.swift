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
    
    // MARK: - Setup Cell
    
    func setupCellContent(with model: Character) {
        nameLabel.text = model.name
        idLabel.text = String(model.id)
        fetchCharacterImage(from: model.thumbnail)
    }
    
    // MARK: - Elements
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
            make.left.equalTo(characterImage.snp.right).offset(15)
            make.top.equalTo(snp.top).offset(20)
        }
        
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(snp.bottom).offset(-15)
        }
    }
    
    private func fetchCharacterImage(from imageData: Image) {
        let pathArr = imageData.path.split(separator: ":")
        let path = "https:" + pathArr[1] + "." + imageData.extensionOfImage
        
        guard let imageURL = URL(string: path) else { return }
        DispatchQueue.global(qos: .utility).async {
            do {
                let image = try Data(contentsOf: imageURL)
                DispatchQueue.main.async { [unowned self] in
                    characterImage.image = UIImage(data: image)
                }
            } catch {
                print("Error")
            }
        }
    }
    
    // MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        idLabel.text = nil
        characterImage.image = nil
    }
}
