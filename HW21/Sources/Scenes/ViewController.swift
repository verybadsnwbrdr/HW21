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
    
    private var characters: [Character] = []
    
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
    
    private func fetchCharacter() {
        let stringURL = CharacterURL().getStringURL()
        let request = AF.request(stringURL)
        request.responseDecodable(of: CharacterDataWrapper.self) { data in
            guard let char = data.value else { return }
            let data = char.data.results
            self.characters = data
            print(data)
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = characters[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.setupCellContent(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = characters[indexPath.row]
        let viewController = ModalView()
        viewController.setupViewContent(with: model)
        present(viewController, animated: true)
    }
}

