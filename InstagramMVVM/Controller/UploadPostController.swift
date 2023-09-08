//
//  UploadPostController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import UIKit

final class UploadPostController: UIViewController {
    
    // MARK: - Properties
    // Delegate
    weak var delegate: UploadPostControllerDelegate?
    
    var selectedImg: UIImage? {
        didSet { self.photoImgView.image = self.selectedImg }
    }
    
    
    var user: User?
    
    
    // MARK: - ImageView
    private let photoImgView: UIImageView = {
        return UIImageView().imageConfig()
    }()
    
    
    
    // MARK: - TextView
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
            tv.commentAccessory(currentController: .imageUploadController)
            tv.delegate = self
        return tv
    }()
    
    
    
    // MARK: - Label
    private let charactorCountLabel: UILabel = {
        return UILabel().labelConfig(labelText: "0/100",
                                     textColor: UIColor.lightGray,
                                     fontSize: 14)
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }
    
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // [Background_Color]
        self.view.backgroundColor = UIColor.white
        // [Nav_Controller]
        self.navigationItem.title = "Upload Post"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(self.handleCancelTap))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self,
                                                                 action: #selector(self.didDoneTap))
        
        
        
        
        // [Auto_Layout]
        // photoImgView
        self.view.addSubview(self.photoImgView)
        self.photoImgView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 8,
                                 width: 180, height: 180,
                                 centerX: self.view,
                                 cornerRadius: 10)
        // captionTextField
        self.view.addSubview(self.captionTextView)
        self.captionTextView.anchor(top: self.photoImgView.bottomAnchor, paddingTop: 16,
                                     leading: self.view.leadingAnchor, paddingLeading: 12,
                                     trailing: self.view.trailingAnchor, paddingtrailing: 12,
                                     height: 64)
        // charactorCountLabel
        self.view.addSubview(self.charactorCountLabel)
        self.charactorCountLabel.anchor(bottom: self.captionTextView.bottomAnchor, paddingBottom: -8,
                                        trailing: self.view.trailingAnchor, paddingtrailing: 12)
    }
    

    
    
    
    
    // MARK: - Selectors
    @objc private func handleCancelTap() {
        self.dismiss(animated: true)
    }
    @objc private func didDoneTap() {
        guard let img = self.selectedImg,
              let caption = self.captionTextView.text,
              let user = self.user else { return }
        
        self.showLoader(true)
        
        PostService.uploadPost(user: user, caption: caption, image: img) {
            self.showLoader(false)
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
}




// MARK: - TextView_Delegate
extension UploadPostController: UITextViewDelegate {
    // Helper_Functions
    private func checkMaxLenth(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
    // Delegate
    func textViewDidChange(_ textView: UITextView) {
        self.checkMaxLenth(textView)
        let count = textView.text.count
        self.charactorCountLabel.text = "\(count)/100"
    }
}
