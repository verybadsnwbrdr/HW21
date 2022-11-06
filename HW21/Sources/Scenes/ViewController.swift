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
    
    // MARK: - Elements
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        view.addSubview(characterImageView)
    }
    
    private func setupLayout() {
        characterImageView.snp.makeConstraints { make in
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
            let path = "https:" + pathArr[1] + "." + result[0].thumbnail.extensionOfImage

            guard let imageURL = URL(string: path),
                  let imageView = try? Data(contentsOf: imageURL)
            else { return }

            self.characterImageView.image = UIImage(data: imageView)
            print(stringURL)
            print(result)
//            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

