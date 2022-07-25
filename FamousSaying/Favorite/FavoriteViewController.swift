//
//  FavoriteViewController.swift
//  FamousSaying
//
//  Created by peo on 2022/07/22.
//

import UIKit
import CoreData
import Combine

final class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    
    let favoriteView = FavoriteView()
    
    var viewModel = FavoriteViewModel()
    var cancelBag = Set<AnyCancellable>()

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Favorites"

        favoriteView.favoriteQuotesTablewView.delegate = self
        favoriteView.favoriteQuotesTablewView.dataSource = self
        
        binding()
    }
    
    override func loadView() {
        super.loadView()
        self.view = favoriteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.quotes = Persistence.shared.fetchQuotes().reversed()
    }
    
    func binding() {
        viewModel.$quotes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] quote in
                self?.favoriteView.favoriteQuotesTablewView.reloadData()
            }
            .store(in: &cancelBag)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.quotes.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuotesTableCell.identifier, for: indexPath) as? FavoriteQuotesTableCell
        cell?.quoteLabel.text = viewModel.quotes[indexPath.row].quote
        cell?.characterLabel.text = "- " + (viewModel.quotes[indexPath.row].character ?? "")
        cell?.animeLabel.text = viewModel.quotes[indexPath.row].anime
        
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteQuote(viewModel.quotes[indexPath.row])
            favoriteView.favoriteQuotesTablewView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let copy = UIContextualAction(style: .normal, title: "Copy") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            UIPasteboard.general.string = self.viewModel.quotes[indexPath.row].quote
            success(true)
        }
        copy.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [copy])
    }
}
