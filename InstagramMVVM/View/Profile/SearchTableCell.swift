//
//  SearchTableCell.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import UIKit

final class SearchTableCell: UITableViewCell {
    
    // MARK: - Properties
    var viewModel: SearchTableViewModel? { didSet { self.configure() } }
    
    
    
    
    
    // MARK: - Image_View
    private let profileImgView: UIImageView = {
        return UIImageView().imageConfig()
    }()
    
    
    // MARK: - Label
    private let userNameLabel: UILabel = {
        return UILabel().labelConfig(fontName: .bold,
                                     fontSize: 14)
    }()
    
    private let fullNameLabel: UILabel = {
        return UILabel().labelConfig(textColor: UIColor.lightGray)
    }()
    
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [self.userNameLabel,
                                                          self.fullNameLabel],
                                       axis: .vertical,
                                       spacing: 4,
                                       alignment: .leading)
    }()
    
    
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        self.selectionStyle = .none
        // Auto_Layout
        // profileImgView
        self.addSubview(self.profileImgView)
        self.profileImgView.anchor(leading: self.leadingAnchor, paddingLeading: 12,
                                   width: 48, height: 48,
                                   centerY: self,
                                   cornerRadius: 48 / 2)
        // stackView
        self.addSubview(self.stackView)
        self.stackView.anchor(leading: self.profileImgView.trailingAnchor, paddingLeading: 10,
                              centerY: self)
    }
    
    
    private func configure() {
        guard let viewModel = self.viewModel else { return }
        
        self.profileImgView.sd_setImage(with: viewModel.profileImgUrl)
        self.userNameLabel.text = viewModel.userName
        self.fullNameLabel.text = viewModel.fullName
    }
}
