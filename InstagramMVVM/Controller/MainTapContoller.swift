//
//  MainTapContoller.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit
import FirebaseAuth
import YPImagePicker

final class MainTabContoller: UITabBarController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            guard let user = self.user else { return }
            self.configureViewControllers(withUser: user)
        }
    }
    
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkUser()
    }
    
    
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureViewControllers(withUser user: User) {
        self.tabBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barStyle = .default
        
        // Main_TabBar_Controller_Delegate
        self.delegate = self
        
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
        let profileController = ProfileController(user: user)
        let profile = self.templateNavContoller(
            unselectedImg: #imageLiteral(resourceName: "profile_unselected"),
            selectedImg: #imageLiteral(resourceName: "profile_selected"),
            rootController: profileController)

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
    
    func didFinishPickerMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: false) {
                guard let selectedImg = items.singlePhoto?.image else { return }
                
                let controller = UploadPostController()
                    controller.selectedImg = selectedImg
                    controller.delegate = self
                    controller.user = self.user
                let nav = UINavigationController(rootViewController: controller)
                    nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
            }
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    
    
    
    
    // MARK: - API
    private func checkUser() {
        // User가 없다면
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                    controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                    nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
            }
            
            
        // User가 있다면
        } else { self.fetchUser() }
    }
    
    private func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
}


// MARK: - AuthenticationDelegate
extension MainTabContoller: AuthenticationDelegate {
    func authenticationComplete() {
        self.fetchUser()
        self.dismiss(animated: true)
    }
}



// MARK: - UITabBarControllerDelegate
extension MainTabContoller: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = self.viewControllers?.firstIndex(of: viewController)

        if index == 2 {
            var config = YPImagePickerConfiguration()
                config.library.mediaType = .photo
                config.shouldSaveNewPicturesToAlbum = false
                config.startOnScreen = .library
                config.screens = [.library]
                config.hidesStatusBar = false
                config.hidesBottomBar = false
                config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
                picker.modalPresentationStyle = .fullScreen
            
            self.present(picker, animated: true)
            
            self.didFinishPickerMedia(picker)
        }
        return true
    }
}




extension MainTabContoller: UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        
        self.selectedIndex = 0
        controller.dismiss(animated: true)
        
        guard let feedNav = viewControllers?.first as? UINavigationController,
              let feed = feedNav.viewControllers.first as? FeedContoller else { return }
        
        feed.handleRefresh()
        
    }
}
