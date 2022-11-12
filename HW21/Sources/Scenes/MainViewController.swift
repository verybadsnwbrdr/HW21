//
//  MainViewController.swift
//  HW21
//
//  Created by Anton on 06.11.2022.
//

import UIKit
import Alamofire
import SnapKit

final class MainViewController: UIViewController, ShowAlertProtocol {
    
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
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search Character"
        definesPresentationContext = true
        return controller
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        fetchCharacter()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupViewController() {
        title = "Каталог персонажей"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
    
    private func fetchCharacter(with name: String = "") {
        let stringURL = CharacterURL(characterName: name).getStringURL()
        let request = AF.request(stringURL)
        request.responseDecodable(of: CharacterDataWrapper.self) { [unowned self] response in
            showAlert(error: response.error)
            guard let char = response.value else { return }
            let data = char.data.results
            characters = data
            tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
        tableView.deselectRow(at: indexPath, animated: true)
        let model = characters[indexPath.row]
        let viewController = ModalViewController()
        viewController.setupViewContent(with: model)
        present(viewController, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let desiredCharacter = searchController.searchBar.text else { return }
        fetchCharacter(with: desiredCharacter)
    }
}
