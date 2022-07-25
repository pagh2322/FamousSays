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
        return view
    }()
    
    let viewModel = HomeViewModel()
    
    var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Home"
        homeView.cardView.delegate = self
        
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
        
        viewModel.favoriteTrigger
            .receive(on: DispatchQueue.main)
            .sink { [weak self] trigger in
                switch trigger {
                case .yes:
                    self?.homeView.cardView.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    self?.homeView.cardView.favoriteButton.tintColor = .systemYellow
                case .no:
                    self?.homeView.cardView.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                    self?.homeView.cardView.favoriteButton.tintColor = .cGray
                }
            }
            .store(in: &cancelBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentQuote = viewModel.currentQuote {
            viewModel.setFavoriteButton(by: currentQuote)
        }
    }
    
    private func setOpacityTo(_ isHidden: Bool) {
        homeView.cardView.quoteLabel.layer.opacity = isHidden ? 0 : 1
        homeView.cardView.animeLabel.layer.opacity = isHidden ? 0 : 1
        homeView.cardView.characterLabel.layer.opacity = isHidden ? 0 : 1
        homeView.cardView.favoriteButton.layer.opacity = isHidden ? 0 : 1
    }
    
    private func setCardView(with quoteModel: QuoteModel) {
        homeView.cardView.quoteLabel.text = quoteModel.quote
        homeView.cardView.animeLabel.text = quoteModel.anime
        homeView.cardView.characterLabel.text = "- " + quoteModel.character
        viewModel.setFavoriteButton(by: quoteModel)
    }
}

extension HomeViewController: CardViewDelegate {
    func didLeftSwipe() {
        viewModel.forwardCurrentQuote()
    }
    
    func didRightSwipe() {
        viewModel.backwardCurrentQuote()
    }
    
    func didTapFavoriteButton() {
        if viewModel.isFavorited(viewModel.currentQuote!) {
            viewModel.deleteFromFavorite()
        } else {
            viewModel.addToFavorite()
        }
    }
}
