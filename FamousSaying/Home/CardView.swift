//
//  CardView.swift
//  FamousSaying
//
//  Created by peo on 2022/07/25.
//

import UIKit

final class CardView: UIView {
    
    // MARK: - Properties
    
    let quoteLabel: BaseLabel = {
        let label = BaseLabel(size: .normal, weight: .semibold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func makeSubviews() {
        [quoteLabel,
         animeLabel,
         characterLabel].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let quoteLabelConstraints = [quoteLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                                     quoteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                     quoteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        
        let characterLabelConstraints = [characterLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 12),
                                         characterLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
                                         characterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        
        let animeLabelConstraints = [animeLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor),
                                     animeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
                                     animeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
                                     animeLabel.trailingAnchor.constraint(equalTo: characterLabel.trailingAnchor)]
        
        
        [quoteLabelConstraints,
         characterLabelConstraints,
         animeLabelConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
}
