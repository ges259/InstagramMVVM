//
//  NotificationController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit

final class NotificationsController: UITableViewController {
    
    // MARK: - Properties
    private var notifications = [Notification]() { didSet { self.tableView.reloadData() } }
     
    private let refresher = UIRefreshControl()
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.fetchNotifications()
    }
    
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureUI() {
        // Background_Color
        self.view.backgroundColor = UIColor.white
        // Nav_Title
        self.navigationItem.title = "Notification"
        
        // Register
        self.tableView.register(NotificationCell.self, forCellReuseIdentifier: Identifier.notification_Ta_Cell)
        self.tableView.separatorStyle = .none
        
        // refresher
        self.refresher.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        self.tableView.refreshControl = self.refresher
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleRefresh() {
        self.fetchNotifications(refresh: true)
    }
    
    
    
    
    
    // MARK: - API
    private func fetchNotifications(refresh: Bool = false) {
        if refresh == true { self.notifications.removeAll() }
        NotificationService.fetchNotifications { notifications in
            self.notifications = notifications
            if refresh == true { self.refresher.endRefreshing() }
        }
    }
}



// MARK: - DataSource
extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.notification_Ta_Cell,
                                                 for: indexPath) as! NotificationCell
            cell.delegate = self
        
            cell.viewModel = NotificationViewModel(notification: self.notifications[indexPath.row])
        return cell
    }
}



// MARK: - Delegate
extension NotificationsController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uid = notifications[indexPath.row].currentUid
        self.showLoader(true)
        UserService.fetchUser(withUid: uid) { user in
            self.showLoader(false)
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}





// MARK: - NotificationCellDelegate
extension NotificationsController: NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        self.showLoader(true)
        UserService.follow(uid: uid) {
            self.showLoader(false)
            cell.viewModel?.userIsFollow.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToUnFollow uid: String) {
        self.showLoader(true)
        UserService.unFollow(uid: uid) {
            self.showLoader(false)
            cell.viewModel?.userIsFollow.toggle()
        }
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        self.showLoader(true)
        PostService.fetchPost(postId: postId) { post in
            self.showLoader(false)
            let controller = FeedContoller(collectionViewLayout: UICollectionViewFlowLayout())
                controller.post = post
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
