//
//  ModalViewController.swift
//  HW21
//
//  Created by Anton on 09.11.2022.
//

import UIKit
import SnapKit
import Alamofire

final class ModalViewController: UIViewController, FetchImageProtocol, ShowAlertProtocol {
    
    // MARK: - Properties
    
    private var character: Character?
    
    // MARK: - SetupView
    
    func setupViewContent(with characterModel: Character) {
        self.character = characterModel
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var modalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "О персонаже"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var characterImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "question")
        return imageView
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.contentMode = .center
        stack.spacing = 10
        return stack
    }()
    
    private lazy var collectionHeader: UILabel = {
        let label = UILabel()
        label.text = "Комиксы с этим персонажем"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(modalTitleLabel)
        view.addSubview(characterImage)
        view.addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(idLabel)
        view.addSubview(collectionHeader)
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        modalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        characterImage.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(modalTitleLabel.snp.bottom).offset(10)
            make.width.height.equalTo(180)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(characterImage.snp.centerY)
            make.left.equalTo(characterImage.snp.right).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        collectionHeader.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(characterImage.snp.bottom).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionHeader.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - NetWorking
    
    private func fetchComics(with path: String, complition: @escaping ([Comic]) -> ()) {
        let stringQueryItems = CharacterURL().getStringQueryItems()
        let stringURL = path + stringQueryItems
        let request = AF.request(stringURL)
        request.responseDecodable(of: ComicDataWrapper.self) { data in
            guard let char = data.value else { return }
            let data = char.data.results
            complition(data)
        }
    }
}

// MARK: - Delegates and DataSource

extension ModalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = character?.comics.items.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell,
              let model = character?.comics.items[indexPath.item] else { return UICollectionViewCell() }
        fetchComics(with: model.resourceURI) { comics in
            guard let comic = comics.first else { return }
            cell.setupCellContent(with: comic)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2) - EdgeInsets.widthSpacing,
               height: (view.frame.width / 1.5) - EdgeInsets.heightSpacing)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: EdgeInsets.topInsets,
                     left: EdgeInsets.leftAndRightInsets,
                     bottom: EdgeInsets.bottomInsets,
                     right: EdgeInsets.leftAndRightInsets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        EdgeInsets.spacingInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        EdgeInsets.spacingInSection
    }
}

// MARK: - EdgeInsets

extension ModalViewController {
    private enum EdgeInsets {
        static let leftAndRightInsets: CGFloat  = 20
        static let bottomInsets: CGFloat = 20
        static let topInsets: CGFloat = 0
        static let spacingInSection: CGFloat = 10
        
        static var widthSpacing: CGFloat {
            (Self.leftAndRightInsets * 2 + Self.spacingInSection) / 2
        }
        
        static var heightSpacing: CGFloat {
            (Self.spacingInSection) / 2
        }
    }
}
