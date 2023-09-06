//
//  ProfileHeader.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit

final class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    
    
    
    
    
    
    
    
    
    
    private let profileImageView: UIImageView = {
        return UIImageView().imageConfig()
    }()
    
    
    
    // MARK: - Label
    private let nameLabel: UILabel = {
        return UILabel().labelConfig(labelText: "Eddie Brock",
                                     fontName: .bold,
                                     fontSize: 14)
    }()
    private lazy var postLabel: UILabel = {
        let lbl = UILabel().profileLabel()
            lbl.attributedText = self.labelAttributedTxt(int: 1, string: "post")
        return lbl
    }()
    private lazy var followersLabel: UILabel = {
        let lbl = UILabel().profileLabel()
            lbl.attributedText = self.labelAttributedTxt(int: 1, string: "followers")
        return lbl
    }()
    private lazy var followingLabel: UILabel = {
        let lbl = UILabel().profileLabel()
            lbl.attributedText = self.labelAttributedTxt(int: 1, string: "following")
        
        return lbl
    }()
    
    
    // MARK: - Button
    private lazy var editProfileBtn: UIButton = {
        let btn = UIButton().buttonConfig(title: "Edit Prifile",
                                          fontName: FontStyle.bold,
                                          fontSize: 14,
                                          borderColor: UIColor.lightGray)
        
            btn.addTarget(self, action: #selector(self.handleEditPrifileBtnTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var gridBtn: UIButton = {
        return UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "grid"))
    }()
    private lazy var listBtn: UIButton = {
        return UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "list"))
    }()
    private lazy var bookmarkBtn: UIButton = {
        return UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "ribbon"))
    }()
    
    
    
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [self.postLabel,
                                                          self.followersLabel,
                                                          self.followingLabel],
                                       axis: .horizontal,
                                       distribution: .fillEqually)
    }()
    private lazy var buttonStackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [self.gridBtn,
                                                          self.listBtn,
                                                          self.bookmarkBtn],
                                       axis: .horizontal,
                                       distribution: .fillEqually)
    }()
    
    
    
    
    
    // MARK: - UIView
    private let topSeparator: UIView = {
        let view = UIView()
            view.backgroundColor = .black
        return view
    }()
    private let bottomSeparator: UIView = {
        let view = UIView()
            view.backgroundColor = .black
        return view
    }()
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        
        
        
        // MARK: - Fix
        self.profileImageView.image = UIImage(named: "venom-7")
        // Auto_layout
        // profileImageView
        self.addSubview(self.profileImageView)
        self.profileImageView.anchor(top: self.topAnchor, paddingTop: 16,
                                     leading: self.leadingAnchor, paddingLeading: 12,
                                     width: 80, height: 80,
                                     cornerRadius: 80 / 2)
        // nameLabel
        self.addSubview(self.nameLabel)
        self.nameLabel.anchor(top: self.profileImageView.bottomAnchor, paddingTop: 12,
                              leading: self.leadingAnchor, paddingLeading: 12)
        // editProfileBtn
        self.addSubview(self.editProfileBtn)
        self.editProfileBtn.anchor(top: self.nameLabel.bottomAnchor, paddingTop: 16,
                                   leading: self.leadingAnchor, paddingLeading: 24,
                                   trailing: self.trailingAnchor, paddingtrailing: 24)
        // stackView
        self.addSubview(self.stackView)
        self.stackView.anchor(leading: self.profileImageView.trailingAnchor, paddingLeading: 12,
                              trailing: self.trailingAnchor, paddingtrailing: 12,
                              centerY: self.profileImageView)
        // buttonStackView
        self.addSubview(self.buttonStackView)
        self.buttonStackView.anchor(bottom: self.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    trailing: self.trailingAnchor,
                                    height: 50)
        // topSeparator
        self.addSubview(self.topSeparator)
        self.topSeparator.anchor(bottom: self.buttonStackView.topAnchor,
                                 leading: self.leadingAnchor,
                                 trailing: self.trailingAnchor,
                                 height: 0.5)
        // bottomSeparator
        self.addSubview(self.bottomSeparator)
        self.bottomSeparator.anchor(top: self.buttonStackView.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    trailing: self.trailingAnchor,
                                    height: 0.5)
        
        
        
    }
    func labelAttributedTxt(int: Int, string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString().attributedText(type1TextString: "\(int)\n",
                                                          type1FontName: .bold,
                                                          type1FontSize: 14,
                                                          type1Foreground: UIColor.black,
                                                          type2TextString: string,
                                                          type2FontSize: 14,
                                                          type2Foreground: UIColor.lightGray)
    }
     
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleEditPrifileBtnTap() {
        print(#function)
    }
    
    
    
    
    
    
    
}
