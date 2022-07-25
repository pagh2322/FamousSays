//
//  HomeView.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Properties
    
    let cardView: CardView = {
        let view = CardView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .gray
        button.layer.opacity = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        [cardView, favoriteButton].forEach { self.addSubview($0) }
    }
    
    private func makeConstraints() {
        let cardViewConstraints = [cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
                                   cardView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
                                   cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                   cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        let favoriteButtonConstrains = [favoriteButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
                                        favoriteButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)]
        
        [cardViewConstraints, favoriteButtonConstrains].forEach { NSLayoutConstraint.activate($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
