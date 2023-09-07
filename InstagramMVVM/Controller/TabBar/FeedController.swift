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
    
    
    
    
    
    
    
    
    

    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }
    
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureUI() {
        // register_CollectionView
        self.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: Identifier.feed_Col_Cell)
        
        self.navigationItem.title = "Feed"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self,
                                                                action: #selector(self.handleLogout))
        
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

        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    
    // MARK: - API
    
    
}





// MARK: - Collection_View
extension FeedContoller {
    // 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    // Cell_For_Row_At
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.feed_Col_Cell, for: indexPath) as! FeedCell
        
        
        return cell
    }
}


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
