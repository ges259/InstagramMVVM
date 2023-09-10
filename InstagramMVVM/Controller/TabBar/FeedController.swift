//
//  FeedController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit
import FirebaseAuth

final class FeedContoller: UICollectionViewController {
    
    // MARK: - Properties
    private var posts = [Post]() { didSet { self.collectionView.reloadData() } }
    
    var post: Post? { didSet { self.collectionView.reloadData() } }
    
    let refresher = UIRefreshControl()

    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        
        if post != nil {
            self.collectionView.isScrollEnabled = false
            self.checkPostLiked()
        } else {
            self.fetchPosts()
        }
    }
    
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureUI() {
        // register_CollectionView
        self.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: Identifier.feed_Col_Cell)
        
        self.navigationItem.title = "Feed"
        
        if self.post == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "logout", style: .plain, target: self,
                action: #selector(self.handleLogout))
        }
        
        self.refresher.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        self.collectionView.refreshControl = self.refresher
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let conrtroller = LoginController()
                conrtroller.delegate = self.tabBarController as? MainTabContoller
            let nav = UINavigationController(rootViewController: conrtroller)
                nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)

        } catch { print("DEBUG: Failed to sign out") }
    }
    
    @objc func handleRefresh() {
        self.posts.removeAll()
        self.fetchPosts()
    }
    
    
    
    
    // MARK: - API
    private func fetchPosts() {
        self.refresher.endRefreshing()
        PostService.fetchFeedPost { postIds in
            self.posts = postIds
        }
        
    }
    private func checkPostLiked() {
        guard let postId = post?.postId else { return }
        PostService.checkPostLikes(postId: postId) { didLike in
            self.post?.didLike = didLike
        }
    }
}





// MARK: - DataSource
extension FeedContoller {
    // 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.post == nil ? self.posts.count : 1
    }
    // Cell_For_Row_At
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.feed_Col_Cell, for: indexPath) as! FeedCell
            cell.delegate = self
        if let post = self.post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: self.posts[indexPath.row])
        }
        return cell
    }
}


// MARK: - FlowLayout
extension FeedContoller: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height = width + 166
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}




extension FeedContoller: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowCommentFor post: Post) {
        
        let controller = CommentController(post: post)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        
        guard let tapBar = tabBarController as? MainTabContoller,
              let currentUser = tapBar.user else { return }
        
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            print("DEBUG: Unlike post here..")
            PostService.unLikePost(post: post) {
                cell.viewModel?.post.likes -= 1
                print("DEBUG: UnLike post did complete")
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeBtn.tintColor = .black
            }
            
            
        } else {
            print("DEBUG: like post here..")
            PostService.likePost(post: post) {
                cell.viewModel?.post.likes += 1
                print("DEBUG: Like post did complete")
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeBtn.tintColor = .red
                
                NotificationService.uploadNotification(toUid: post.postOwnerUid,
                                                       currentUser: currentUser,
                                                       type: .like,
                                                       post: post)
            }
        }
    }
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

}
