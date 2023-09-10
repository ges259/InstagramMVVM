//
//  ProfileHeader.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit



final class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    var viewModel: ProfileHeaderViewModel? { didSet { configure() } }
    
    // Delegate
    weak var delegate: ProfileHeaderDelegate?
    
    
    
    
    
    
    // MARK: - Image_View
    private let profileImageView: UIImageView = {
        return UIImageView().imageConfig()
    }()
    
    
    
    
    // MARK: - Button
    private let nameLabel: UILabel = UILabel().labelConfig(fontName: .bold,
                                                           fontSize: 14)
    
    private lazy var postLabel: UILabel = UILabel().profileLabel()
    
    private lazy var followersLabel: UILabel = UILabel().profileLabel()
    
    
    private lazy var followingLabel: UILabel = UILabel().profileLabel()
    
    private lazy var editProfileBtn: UIButton = UIButton().buttonConfig(fontName: FontStyleEnum.bold,
                                                                        fontSize: 14,
                                                                        borderColor: UIColor.lightGray)
    
    private lazy var gridBtn: UIButton = UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "grid"))
        
    private lazy var listBtn: UIButton = UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "list"))
        
    private lazy var bookmarkBtn: UIButton = UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "ribbon"))
    
    
    
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = UIStackView().stackView(arrangedSubviews:
                                                                        [self.postLabel,
                                                                         self.followersLabel,
                                                                         self.followingLabel],
                                                                      axis: .horizontal,
                                                                      distribution: .fillEqually)
        
    private lazy var buttonStackView: UIStackView = UIStackView().stackView(arrangedSubviews:
                                                                                [self.gridBtn,
                                                                                 self.listBtn,
                                                                                 self.bookmarkBtn],
                                                                            axis: .horizontal,
                                                                            distribution: .fillEqually)
        
    
    // MARK: - UIView
    private let topSeparator: UIView = UIView().backgroundColorView(color: UIColor.black)
        
    private let bottomSeparator: UIView = UIView().backgroundColorView(color: UIColor.black)
        
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
        self.addSelectors()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
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
                              centerX: self.profileImageView)
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

    
    
    
    private func configure() {
        guard let viewModel = self.viewModel else { return }
        
        self.nameLabel.text = viewModel.fullName
        self.profileImageView.sd_setImage(with: viewModel.profileImgUrl)
        
        self.postLabel.attributedText = viewModel.numPosts
        self.followersLabel.attributedText = viewModel.numFollowers
        self.followingLabel.attributedText = viewModel.numFollowing
        
        self.editProfileBtn.setTitle(viewModel.followBtnText, for: .normal)
        self.editProfileBtn.setTitleColor(viewModel.followBtnTitleColor, for: .normal)
        self.editProfileBtn.backgroundColor = viewModel.followBtnBackgroundColor
    }
    
    
    private func addSelectors() {
        self.editProfileBtn.addTarget(self, action: #selector(self.handleEditPrifileBtnTap), for: .touchUpInside)
    }
     
    
    
    
    // MARK: - Selectors
    @objc private func handleEditPrifileBtnTap() {
        guard let viewModel = self.viewModel else { return }
        self.delegate?.header(self, didTapActionBtnFor: viewModel.user)
    }
}
