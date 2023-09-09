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
    let placeholderLabel: UILabel = {
        return UILabel().labelConfig(textColor: UIColor.lightGray,
                                     fontSize: 13)
    }()
    
    
    
    var placeHolderShouldCenter = true {
        didSet {
            if self.placeHolderShouldCenter {
                self.placeholderLabel.anchor(top: self.topAnchor, paddingTop: 7,
                                             leading: self.leadingAnchor, paddingLeading: 8,
                                             trailing: self.trailingAnchor)
                
            } else {
                self.placeholderLabel.anchor(top: self.topAnchor, paddingTop: 8,
                                             leading: self.leadingAnchor, paddingLeading: 8)
            }
        }
    }
    
    
    
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

        
        // Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextDidChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    

    
    func commentAccessory(currentController: InputTextViewEnum) {
        
        if currentController == .commentAccessoryView {
            self.font = UIFont.systemFont(ofSize: 15)
            self.isScrollEnabled = false

            self.placeholderText = "Enter comment.."
            self.placeHolderShouldCenter = true
        } else {
            self.placeholderText = "Enter caption.."
            self.font = UIFont.systemFont(ofSize: 16)
            self.placeHolderShouldCenter = false
        }
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleTextDidChanged() {
        self.placeholderLabel.isHidden = !text.isEmpty
    }
}
