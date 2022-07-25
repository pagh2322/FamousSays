//
//  FavoriteView.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//

import UIKit

final class FavoriteView: UIView {
    
    // MARK: - Properties
    
    let favoriteQuotesTablewView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteQuotesTableCell.self, forCellReuseIdentifier: FavoriteQuotesTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        self.addSubview(favoriteQuotesTablewView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([favoriteQuotesTablewView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                                     favoriteQuotesTablewView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                                     favoriteQuotesTablewView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     favoriteQuotesTablewView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
