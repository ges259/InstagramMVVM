//
//  MainTapContoller.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit
import FirebaseAuth
final class MainTabContoller: UITabBarController {
    
    // MARK: - Properties
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.configureViewControllers()
        self.checkUser()
    }
    
    
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureViewControllers() {
        self.tabBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barStyle = .default
        
        // Feed_Controller
        let feedLayout = UICollectionViewFlowLayout()
        let feed = self.templateNavContoller(
            unselectedImg: #imageLiteral(resourceName: "home_unselected"),
            selectedImg: #imageLiteral(resourceName: "home_selected"),
            rootController: FeedContoller(collectionViewLayout: feedLayout))
        
        // Search_Controller
        let search = self.templateNavContoller(
            unselectedImg: #imageLiteral(resourceName: "search_unselected"),
            selectedImg: #imageLiteral(resourceName: "search_selected"),
            rootController: SearchController())
        
        // ImageSelector_Controller
        let imageSelector = self.templateNavContoller(
            unselectedImg: #imageLiteral(resourceName: "plus_unselected"),
            selectedImg: #imageLiteral(resourceName: "home_unselected"),
            rootController: ImageSelectorController())

        // Notification_Controller
        let notifications = self.templateNavContoller(
            unselectedImg: #imageLiteral(resourceName: "like_unselected"),
            selectedImg: #imageLiteral(resourceName: "like_selected"),
            rootController: NotificationsController())

        // Profile_Controller
        let profileLayout = UICollectionViewFlowLayout()
        let profile = self.templateNavContoller(
            unselectedImg: #imageLiteral(resourceName: "profile_unselected"),
            selectedImg: #imageLiteral(resourceName: "profile_selected"),
            rootController: ProfileController(collectionViewLayout: profileLayout))

        // TabBar에 추가
        self.viewControllers = [feed, search, imageSelector, notifications, profile]
    }
    
    private func templateNavContoller(unselectedImg: UIImage,
                                      selectedImg: UIImage,
                                      rootController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootController)
            nav.tabBarItem.image = unselectedImg
            nav.tabBarItem.selectedImage = selectedImg
            nav.navigationBar.tintColor = UIColor.black
        return nav
    }
    
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    
    
    
    
    // MARK: - API
    private func checkUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                    nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
            }
        }
    }
}
