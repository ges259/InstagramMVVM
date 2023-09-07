//
//  SearchContoller.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit

final class SearchController: UITableViewController {
    
    // MARK: - Properties
    
    
    private var users = [User]()
    private var filterUsers = [User]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    private var isSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchController()
        self.configureUI()
        self.fetchUsers()
        
    }
    
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureUI() {
        
        // TableView_Register
        self.tableView.register(SearchTableCell.self, forCellReuseIdentifier: Identifier.Search_Ta_cell)
        
    }
    
    
    private func configureSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "SearchBar"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = false
    }
    
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    
    
    
    
    // MARK: - API
    private func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}



// MARK: - DataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.isSearchMode
        ? self.filterUsers.count
        : self.users.count
        
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Search_Ta_cell, for: indexPath) as! SearchTableCell
        
        let user = self.isSearchMode
        ? self.filterUsers[indexPath.row]
        : self.users[indexPath.row]
        
        cell.viewModel = SearchTableViewModel(user: user)
        
        return cell
    }
}


// MARK: - Delegate
extension SearchController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = ProfileController(user: self.users[indexPath.row])
        
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}




extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        self.filterUsers = users.filter({
            $0.userName.contains(searchText)
            || $0.fullName.contains(searchText)})
        
        self.tableView.reloadData()
    }
}
