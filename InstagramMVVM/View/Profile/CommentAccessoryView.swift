//
//  CommentAccessoryView.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import UIKit

final class CommentAccessoryView: UIView {
    
    // MARK: - Propertis
    weak var delegate: CommentInputAccessoryViewDelegate?
    
    
    
    
    
    // MARK: - Layout
    private let commentView: InputTextView = {
        let tv = InputTextView()
            tv.commentAccessory(currentController: .commentAccessoryView)
        return tv
    }()
    
    private lazy var postBtn: UIButton = UIButton().buttonConfig(title: "Post",
                                                                 fontName: FontStyleEnum.bold,
                                                                 fontSize: 14)
    
    
    private let dividerView: UIView = UIView().backgroundColorView(color: UIColor.lightGray)
        
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
        self.addSelectors()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // Background_Color
        self.backgroundColor = UIColor.white
        // auto_resizing_Height
        self.autoresizingMask = .flexibleHeight
        // [Auto_Layout]
        // postBtn
        self.addSubview(self.postBtn)
        self.postBtn.anchor(top: self.topAnchor,
                            trailing: self.trailingAnchor, paddingtrailing: 8,
                            width: 50, height: 50)
        // commentView
        self.addSubview(self.commentView)
        self.commentView.anchor(top: self.topAnchor, paddingTop: 8,
                                bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 8,
                                leading: self.leadingAnchor, paddingLeading: 8,
                                trailing: self.postBtn.leadingAnchor, paddingtrailing: 8)
        // dividerView
        self.addSubview(self.dividerView)
        self.dividerView.anchor(top: self.topAnchor,
                                leading: self.leadingAnchor,
                                trailing: self.trailingAnchor,
                                height: 0.5)
    }
    
    func clearCommentTextView() {
        self.commentView.text = nil
        self.commentView.placeholderLabel.isHidden = false
    }
    
    private func addSelectors() {
        self.postBtn.addTarget(self, action: #selector(self.handlePostTap), for: .touchUpInside)
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handlePostTap() {
        self.delegate?.inputView(self, wantsToUploadComment: self.commentView.text)
    }
    
}
