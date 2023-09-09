//
//  NotificationCell.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/09.
//

import UIKit

final class NotificationCell: UITableViewCell {
    
    // MARK: - Properties
    var viewModel: NotificationViewModel? { didSet { self.configure() } }
    
    weak var delegate: NotificationCellDelegate?
    
    
    // MARK: - Layout
    private let profileImgView: UIImageView = UIImageView().imageConfig()
    
    private let postImgView: UIImageView = UIImageView().imageConfig(userInteraction: true)
    
    private let infoLabel: UILabel = {
        let lbl = UILabel().labelConfig(fontName: .bold,
                                        fontSize: 14)
            lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var followBtn: UIButton = UIButton().buttonConfig(title: "Loading",
                                                                   fontName: FontStyleEnum.bold,
                                                                   fontSize: 14,
                                                                   borderColor: UIColor.lightGray)
    
    
    
    
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureUI()
        self.addSelectorsAndGesture()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // Selection_Style
        self.selectionStyle = .none
        // Auto_Layout
        // profileImgView
        self.addSubview(self.profileImgView)
        self.profileImgView.anchor(leading: self.leadingAnchor, paddingLeading: 12,
                                   width: 48, height: 48,
                                   centerY: self,
                                   cornerRadius: 48 / 2)
        // followBtn
        self.contentView.addSubview(self.followBtn)
        self.followBtn.anchor(trailing: self.trailingAnchor, paddingtrailing: 12,
                              width: 88, height: 32,
                              centerY: self)
        // postImgView
        self.contentView.addSubview(self.postImgView)
        self.postImgView.anchor(trailing: self.trailingAnchor, paddingtrailing: 12,
                                width: 48, height: 48,
                                centerY: self)
        // infoLabel
        self.contentView.addSubview(self.infoLabel)
        self.infoLabel.anchor(leading: self.profileImgView.trailingAnchor, paddingLeading: 8,
                              centerY: self.profileImgView)
    }
    
    
    
    private func addSelectorsAndGesture() {
        // postImgView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handlePostTap))
        self.postImgView.addGestureRecognizer(tap)
        
        // followBtn
        self.followBtn.addTarget(self, action: #selector(self.handleFollowBtnTap), for: .touchUpInside)
    }
    
    
    
    private func configure() {
        guard let viewModel = self.viewModel else { return }
        self.infoLabelAnchor(type: viewModel.notificationType)
        
        self.profileImgView.sd_setImage(with: viewModel.profileImageURL)
        self.infoLabel.attributedText = viewModel.notificationLabel
        self.postImgView.sd_setImage(with: viewModel.postImageURL)
        
        self.followBtn.setTitle(viewModel.followBtnText, for: .normal)
        self.followBtn.setTitleColor(viewModel.followBtnTextColor, for: .normal)
        self.followBtn.backgroundColor = viewModel.followBtnBackgroundColor
    }

   
    
    private func infoLabelAnchor(type: NotificationEnum) {
        // .follow
        if type == .follow {
            self.followBtn.isHidden = false
            self.postImgView.isHidden = true
            
            self.infoLabel.setWidth(self.frame.width - 173)
            
            
        // .comment || .like
        } else {
            self.followBtn.isHidden = true
            self.postImgView.isHidden = false
            
            self.infoLabel.setWidth(self.frame.width - 140)
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleFollowBtnTap() {
        guard let viewModel = self.viewModel else { return }
        
        if viewModel.userIsFollow {
            self.delegate?.cell(self, wantsToUnFollow: viewModel.notificationUid)
        } else {
            self.delegate?.cell(self, wantsToFollow: viewModel.notificationUid)
        }
    }
    
    @objc private func handlePostTap() {
        guard let postId = self.viewModel?.returnPostId else { return }
        self.delegate?.cell(self, wantsToViewPost: postId)
    }
}
