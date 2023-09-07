//
//  ProfileCell.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    
    
    
    
    
    
    
    // MARK: - ImageView
    private let postImageView: UIImageView = {
        return UIImageView().imageConfig()
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
        self.postImageView.image = UIImage(named: "venom-7")
        self.addSubview(self.postImageView)
        self.postImageView.anchor(top: self.topAnchor,
                                  bottom: self.bottomAnchor,
                                  leading: self.leadingAnchor,
                                  trailing: self.trailingAnchor)
    }
    
    
    
    
    
    
}
