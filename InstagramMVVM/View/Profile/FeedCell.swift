//
//  FeedCell.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit

final class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    var viewModel: PostViewModel? {
        didSet { self.configure()}
    }
    
    weak var delegate: FeedCellDelegate?
    
    
    
    // MARK: - Image_View
    private lazy var profileImgView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "venom-7")).imageConfig(userInteraction: true)
        return img
    }()
    
    private lazy var postImgView: UIImageView = {
        let img = UIImageView().imageConfig(userInteraction: true)
        return img
    }()
    
    
    
    
    // MARK: - Button
    private lazy var userNameBtn: UIButton = {
        let btn = UIButton().buttonConfig(title: "venom",
                                          titleColor: UIColor.black)
            btn.addTarget(self, action: #selector(self.UserNameTap),
                          for: .touchUpInside)
        return btn
    }()
    lazy var likeBtn: UIButton = {
        let btn = UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "like_unselected"))
            btn.addTarget(self, action: #selector(likeBtntap), for: .touchUpInside)
        return btn
    }()
    private lazy var commentBtn: UIButton = {
        let btn = UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "comment"))
        btn.addTarget(self, action: #selector(self.handleCommentTap), for: .touchUpInside)
        return btn
    }()
    private lazy var shareBtn: UIButton = {
        return UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "send2"))
    }()
    
    
    
    
    
    // MARK: - Label
    private let likesLabel: UILabel = {
        return UILabel().labelConfig(labelText: "1 likes",
                                     fontName: .bold)
    }()
    private let captionLabel: UILabel = {
        return UILabel().labelConfig(fontName: .bold)
    }()
    private let postTimeLabel: UILabel = {
        return UILabel().labelConfig(labelText: "2 days ago",
                                     textColor: UIColor.lightGray)
    }()
    
    
    
    
    
    // MARK: - Stack_View
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [self.likeBtn,
                                                          self.commentBtn,
                                                          self.shareBtn],
                                       axis: .horizontal,
                                       alignment: .center,
                                       distribution: .fillEqually)
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        
        // Auto_Layout
        // profileImgView
        self.addSubview(self.profileImgView)
        self.profileImgView.anchor(top: self.topAnchor, paddingTop: 12,
                                   leading: self.leadingAnchor, paddingLeading: 12,
                                   width: 40, height: 40,
                                   cornerRadius: 40 / 2)
        // userNameBtn
        self.addSubview(self.userNameBtn)
        self.userNameBtn.centerY(inView: self.profileImgView,
                                 leadingAnchor: self.profileImgView.trailingAnchor,
                                 paddingleading: 8)
        // postImgView
        self.addSubview(self.postImgView)
        self.postImgView.anchor(top: self.profileImgView.bottomAnchor, paddingTop: 8,
                                leading: self.leadingAnchor,
                                trailing: self.trailingAnchor,
                                height: self.frame.width)
        // stackView
        self.addSubview(self.stackView)
        self.stackView.anchor(top: self.postImgView.bottomAnchor,
                              width: 120, height: 50)
        // likesLabel
        self.addSubview(self.likesLabel)
        self.likesLabel.anchor(top: self.likeBtn.bottomAnchor, paddingTop: 6,
                               leading: self.leadingAnchor, paddingLeading: 8)
        // captionLabel
        self.addSubview(self.captionLabel)
        self.captionLabel.anchor(top: self.likesLabel.bottomAnchor, paddingTop: 7,
                                 leading: self.leadingAnchor, paddingLeading: 8)
        // postTimeLabel
        self.addSubview(self.postTimeLabel)
        self.postTimeLabel.anchor(top: self.captionLabel.bottomAnchor, paddingTop: 5,
                                  leading: self.leadingAnchor, paddingLeading: 8)
    }
    
    private func configure() {
        guard let viewModel = self.viewModel else { return }
        
        self.captionLabel.text = viewModel.caption
        self.postImgView.sd_setImage(with: viewModel.imageURL)
        
        self.profileImgView.sd_setImage(with: viewModel.profileImageURL)
        self.userNameBtn.setTitle(viewModel.userName, for: .normal)
        
        self.likesLabel.text = viewModel.likesLabelText
        self.likeBtn.setImage(viewModel.likeBtnImg, for: .normal)
        self.likeBtn.tintColor = viewModel.likeBtnTintColor
        
        
        
    }
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func UserNameTap() {
        print(#function)
    }
    @objc private func likeBtntap() {
        guard let viewModel = self.viewModel else { return }
        self.delegate?.cell(self, didLike: viewModel.post)
    }
    
    @objc private func handleCommentTap() {
        guard let viewModel = self.viewModel else { return }
        self.delegate?.cell(self, wantsToShowCommentFor: viewModel.post)
    }
    
    
    
    
    
    

}
