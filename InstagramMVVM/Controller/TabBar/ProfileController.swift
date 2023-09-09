//
//  ProfileController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//s

import UIKit

final class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    private var user: User { didSet { self.collectionView.reloadData() } }
    
    private var posts = [Post]()
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.checkIfUserFollowed()
        self.fetchUserStats()
        self.fetchPosts()
    }
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper_Funtions
    private func configureUI() {
        self.collectionView.backgroundColor = UIColor.white
        self.navigationItem.title = self.user.userName
        self.collectionView.register(ProfileCell.self,
                                     forCellWithReuseIdentifier: Identifier.profile_Col_Cell)
        self.collectionView.register(ProfileHeader.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: Identifier.profile_Header)
    }
    
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    
    
    
    
    // MARK: - API
    private func checkIfUserFollowed() {
        UserService.checkIfUserIsFollowed(uid: self.user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    private func fetchUserStats() {
        UserService.fetchUserStats(uid: self.user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    private func fetchPosts() {
        PostService.fetchPostsCount(uid: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
}






// MARK: - ProfileHeaderDelegate
    // edit_Profile / follow / unfollow 버튼
extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionBtnFor user: User) {
        guard let tapBar = tabBarController as? MainTabContoller,
              let currentUser = tapBar.user else { return }
        
        
        // edit_Profile 버튼
        if user.isCurrentUser {
            print("DEBUG: Show edit profile here..")
            
            
        // following 상태 버튼 (unfollow)
        } else if user.isFollowed {
            UserService.unFollow(uid: user.uid) {
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
            
        // follow 상태 버튼 (follow)
        } else {
            UserService.follow(uid: user.uid) {
                self.user.isFollowed = true
                self.collectionView.reloadData()
                
                // Notification
                NotificationService.uploadNotification(toUid: self.user.uid,
                                                       currentUser: currentUser,
                                                       type: .follow)
            }
        }
    }
}


















// MARK: - DataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.profile_Col_Cell, for: indexPath) as! ProfileCell
        
        cell.viewModel = PostViewModel(post: self.posts[indexPath.row])
        return cell
    }
    
    
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: Identifier.profile_Header,
                                                                     for: indexPath) as! ProfileHeader
            header.delegate = self
            header.viewModel = ProfileHeaderViewModel(user: self.user)
        return header
    }
}




// MARK: - Delegate
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedContoller(collectionViewLayout: UICollectionViewFlowLayout())
            controller.post = self.posts[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}





// MARK: - FlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    // 아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    // 좌우 space 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 상하 space 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 240)
    }
}
