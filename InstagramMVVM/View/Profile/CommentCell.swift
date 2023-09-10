//
//  CommentCell.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import UIKit

final class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: CommentViewModel? { didSet { self.configure() } }
    
    
    
    
    // MARK: - Layout
    private let profileImgView: UIImageView = UIImageView().imageConfig()
        
    
    
    
    private lazy var commentLabel = UILabel()
    
    
    
    
    
    
    
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
        // [Auto_Layout]
        // profileImgView
        self.addSubview(self.profileImgView)
        self.profileImgView.anchor(leading: self.leadingAnchor, paddingLeading: 8,
                                   width: 40, height: 40,
                                   centerY: self,
                                   cornerRadius: 40 / 2)
        // commentLabel
        self.commentLabel.numberOfLines = 0
        self.addSubview(self.commentLabel)
        self.commentLabel.anchor(leading: self.profileImgView.trailingAnchor, paddingLeading: 8,
                                 trailing: self.trailingAnchor, paddingtrailing: 8,
                                 centerY: self)
    }
    
    
    
    private func configure() {
        guard let viewModel = self.viewModel else { return }
        self.profileImgView.sd_setImage(with: viewModel.profileImageURL)
        self.commentLabel.attributedText = viewModel.commentLabelText
    }
}
