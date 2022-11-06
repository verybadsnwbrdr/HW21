//
//  ViewController.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var characters: [Character] = []
    
    // MARK: - Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
    
    func fetchCharacter() {
        let stringURL = CharacterURL().getStringUrl()
        let request = AF.request(stringURL)
        request.responseDecodable(of: CharacterDataWrapper.self) { data in
            guard let char = data.value else { return }
            let data = char.data
            let result = data.results
            let pathArr = result[0].thumbnail.path.split(separator: ":")
//            let path = "https:" + pathArr[1] + "." + result[0].thumbnail.extensionOfImage

//            guard let imageURL = URL(string: path),
//                  let imageView = try? Data(contentsOf: imageURL)
//            else { return }
            self.characters = result
//            self.characterImageView.image = UIImage(data: imageView)
//            print(stringURL)
            print(result[0].name)
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.cellModel?.name = characters[indexPath.row].name
        cell.cellModel?.id = characters[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

