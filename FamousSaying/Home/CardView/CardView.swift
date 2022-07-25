//
//  CardView.swift
//  FamousSaying
//
//  Created by peo on 2022/07/25.
//

import UIKit

final class CardView: UIView {
    
    // MARK: - Properties
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .gray
        button.layer.opacity = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    weak var delegate: CardViewDelegate?
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
        makeConstraints()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func makeSubviews() {
        [favoriteButton,
         quoteLabel,
         animeLabel,
         characterLabel].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let favoriteButtonConstrains = [favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                                        favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        
        let quoteLabelConstraints = [quoteLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     quoteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                     quoteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        
        let characterLabelConstraints = [characterLabel.bottomAnchor.constraint(equalTo: animeLabel.topAnchor, constant: -4),
                                         characterLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
                                         characterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        
        let animeLabelConstraints = [animeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
                                     animeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
                                     animeLabel.trailingAnchor.constraint(equalTo: characterLabel.trailingAnchor)]
        
        
        [favoriteButtonConstrains,
         quoteLabelConstraints,
         characterLabelConstraints,
         animeLabelConstraints].forEach { NSLayoutConstraint.activate($0) }
    }
    
    func setDelegate() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didLeftSwipe))
        leftSwipeGesture.direction = .left
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didRightSwipe))
        rightSwipeGesture.direction = .right
        
        [leftSwipeGesture,
         rightSwipeGesture].forEach { self.addGestureRecognizer($0) }
        
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    @objc func didLeftSwipe() {
        delegate?.didLeftSwipe()
    }
    
    @objc func didRightSwipe() {
        delegate?.didRightSwipe()
    }
    
    @objc func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton()
    }
    
}
