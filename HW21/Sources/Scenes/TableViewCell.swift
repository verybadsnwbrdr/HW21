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
        
    }
    
    private func setupLayout() {
        
    }
}
