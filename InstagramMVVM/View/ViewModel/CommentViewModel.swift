//
//  CommentViewModel.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/08.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    
    
    var profileImageURL: URL? { return URL(string: self.comment.profileImageURL) }
    
    
    var userName: String { return self.comment.userName }
    
    var commentText: String { return self.comment.commnetText }
    
    
    var commentLabelText: NSAttributedString {
        return NSMutableAttributedString().attributedText(
            type1TextString: "\(self.comment.userName)  ",
            type1Foreground: .black,
            type1FontName: .bold,
            
            type2TextString: self.comment.commnetText,
            type2Foreground: .black,
            type2FontName: .system,
            type2FontSize: 14)
    }
    
    func size(width: CGFloat) -> CGSize {
        let lbl = UILabel()
            lbl.numberOfLines = 0
            lbl.text = self.comment.commnetText
            lbl.lineBreakMode = .byWordWrapping
            lbl.setWidth(width)
        return lbl.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    
    
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    
    
    
    
    
}
