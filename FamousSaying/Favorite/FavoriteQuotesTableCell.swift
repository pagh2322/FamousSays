//
//  FavoriteQuotesTableCell.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//

import UIKit

final class FavoriteQuotesTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FavoriteQuotesTableCell"
    
    let quoteLabel: BaseLabel = {
        let label = BaseLabel(size: .normal)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterLabel: BaseLabel = {
        let label = BaseLabel(size: .small, textColor: .cGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let animeLabel: BaseLabel = {
        let label = BaseLabel(size: .small, textColor: .cGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [quoteLabel,
         animeLabel,
         characterLabel].forEach { self.contentView.addSubview($0) }
    }
    
    private func makeConstraints() {
        let quoteLabelConstraints = [quoteLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
                                     quoteLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
                                     quoteLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)]
        
        let characterLabelConstraints = [characterLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 12),
                                         characterLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 20),
                                         characterLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)]
        
        let animeLabelConstraints = [animeLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor),
                                     animeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
                                     animeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 20),
                                     animeLabel.trailingAnchor.constraint(equalTo: characterLabel.trailingAnchor)]
        
        
        [quoteLabelConstraints,
         characterLabelConstraints,
         animeLabelConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
