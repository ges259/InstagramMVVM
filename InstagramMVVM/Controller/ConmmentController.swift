//
//  ConmmentController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import UIKit

final class CommentController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let post: Post
    
    private var comments = [Comment]()
    
    
    
    
    
    // MARK: - Layout
    private lazy var commentInputView: CommentAccessoryView = {
        let frame: CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        let cv = CommentAccessoryView(frame: frame)
            cv.delegate = self
        return cv
    }()
    
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.fetchComment()
    }
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // title
        self.navigationItem.title = "Comment"
        // Register
        self.collectionView.register(CommentCell.self, forCellWithReuseIdentifier: Identifier.comment_col_Cell)
        // 아이템의 개수가 적은 경우 Bounce가 되지 않아 [드래드로 키보드를 닫을 수 없기 때문]
        self.collectionView.alwaysBounceVertical = true
        // 드래그하면 키보드가 닫힘
        self.collectionView.keyboardDismissMode = .interactive
    }

    
    
    
    // MARK: - API
    private func fetchComment() {
        CommentService.fetchComment(forPost: self.post.postId) { comment in
            self.comments = comment
            self.collectionView.reloadData()
        }
    }
    
    
    
    
    
    
}


// MARK: - DataSource
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.comment_col_Cell, for: indexPath) as! CommentCell
        
        cell.viewModel = CommentViewModel(comment: self.comments[indexPath.row])
        return cell
    }
}


// MARK: - Delegate
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = self.comments[indexPath.row].uid
        
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}




// MARK: - FlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    // 아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        
        let width = self.view.frame.width
        let height = viewModel.size(width: width).height + 32
        return CGSize(width: width, height: height)
    }
}




extension CommentController: CommentInputAccessoryViewDelegate {
    func inputView(_ inputView: CommentAccessoryView, wantsToUploadComment comment: String) {
        
        guard let tab = self.tabBarController as? MainTabContoller,
              let user = tab.user else { return }
        
        self.showLoader(true)
        
        CommentService.uploadComment(comment: comment, postId: self.post.postId, user: user) {
            self.showLoader(false)
            inputView.clearCommentTextView()
        }
    }
}
