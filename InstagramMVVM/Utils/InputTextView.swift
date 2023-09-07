//
//  InputTextField.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import UIKit

final class InputTextView: UITextView {
    
    // MARK: - Properties
    var placeholderText: String? {
        didSet { self.placeholderLabel.text = placeholderText }
    }
    
    
    
    
    
    // MARK: - Layout
    private let placeholderLabel: UILabel = {
        return UILabel().labelConfig(textColor: UIColor.lightGray,
                                     fontSize: 16)
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // placeholderLabel
        self.addSubview(self.placeholderLabel)
        self.placeholderLabel.anchor(top: self.topAnchor, paddingTop: 6,
                                     leading: self.leadingAnchor, paddingLeading: 8)
        
        // Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextDidChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleTextDidChanged() {
        self.placeholderLabel.isHidden = !text.isEmpty
    }
}
