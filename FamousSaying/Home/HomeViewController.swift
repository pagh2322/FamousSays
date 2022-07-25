//
//  HomeViewController.swift
//  FamousSaying
//
//  Created by peo on 2022/07/22.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        view.cardView.isUserInteractionEnabled = true
        let leftSwipeGesture = UISwipeGestureRecognizer(target: viewModel, action: #selector(viewModel.forwardCurrentQuote))
        leftSwipeGesture.direction = .left
        let rightSwipeGesture = UISwipeGestureRecognizer(target: viewModel, action: #selector(viewModel.backwardCurrentQuote))
        rightSwipeGesture.direction = .right
        
        view.cardView.addGestureRecognizer(leftSwipeGesture)
        view.cardView.addGestureRecognizer(rightSwipeGesture)
        
        return view
    }()
    
    let viewModel = HomeViewModel()
    
    var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Home"
        
        binding()
    }
    
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    func binding() {
        viewModel.$currentQuote
            .receive(on: DispatchQueue.main)
            .sink { [weak self] quoteModel in
                if let quoteModel = quoteModel, let self = self {
                    UIView.animate(withDuration: 0.5) {
                        self.setOpacityTo(true)
                    } completion: { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.setOpacityTo(false)
                            self.setCardView(with: quoteModel)
                        }
                    }
                }
            }
            .store(in: &cancelBag)
        
        homeView.favoriteButton.addTarget(viewModel, action: #selector(viewModel.addToFavorite), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentQuote = viewModel.currentQuote {
            if self.viewModel.isFavorited(currentQuote) {
                self.homeView.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                self.homeView.favoriteButton.tintColor = .systemYellow
            } else {
                self.homeView.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                self.homeView.favoriteButton.tintColor = .gray
            }
        }
    }
    
    private func setOpacityTo(_ isHidden: Bool) {
        if isHidden {
            homeView.cardView.quoteLabel.layer.opacity = 0
            homeView.cardView.animeLabel.layer.opacity = 0
            homeView.cardView.characterLabel.layer.opacity = 0
            homeView.favoriteButton.layer.opacity = 0
        } else {
            homeView.cardView.quoteLabel.layer.opacity = 1
            homeView.cardView.animeLabel.layer.opacity = 1
            homeView.cardView.characterLabel.layer.opacity = 1
            homeView.favoriteButton.layer.opacity = 1
        }
    }
    
    private func setCardView(with quoteModel: QuoteModel) {
        homeView.cardView.quoteLabel.text = quoteModel.quote
        homeView.cardView.animeLabel.text = quoteModel.anime
        homeView.cardView.characterLabel.text = "- " + quoteModel.character
        isFavorited(quoteModel: quoteModel)
    }
    
    private func isFavorited(quoteModel: QuoteModel) {
        if viewModel.isFavorited(quoteModel) {
            homeView.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            homeView.favoriteButton.tintColor = .systemYellow
        } else {
            homeView.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            homeView.favoriteButton.tintColor = .gray
        }
    }
}
