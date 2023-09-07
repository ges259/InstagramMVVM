//
//  Extensions.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//

import UIKit
import JGProgressHUD



// MARK: - UIViewController
extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)

    func configureGradientLayer() {
        // Gradient_Layer
        let gradient = CAGradientLayer()
            gradient.colors = [UIColor.systemPurple.cgColor,
                           UIColor.systemBlue.cgColor]
            gradient.locations = [0, 1]
            gradient.frame = view.frame
        self.view.layer.addSublayer(gradient)
    }

    func showLoader(_ show: Bool) {
        self.view.endEditing(true)

        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }

    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}




// MARK: - UIButton
extension UIButton {
    func attributedTitle(firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    
    func ImgBtnConfig(img: UIImage, tintColor: UIColor = UIColor.black) -> UIButton {
        let btn = UIButton(type: UIButton.ButtonType.system)
            btn.setImage(img, for: .normal)
            btn.tintColor = tintColor
        return btn
    }
    
    
    func buttonConfig(title: String = "",
                      titleColor: UIColor = UIColor.black,
                      
                      fontName: FontStyle = FontStyle.bold,
                      fontSize: CGFloat = 13,
                      
                      borderColor: UIColor? = nil,
                      borderWidth: CGFloat = 0.5) -> UIButton {
        let btn = UIButton()
        // [Title]
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        // [Font]
        btn.titleLabel?.font = fontName == .bold
            ? UIFont.boldSystemFont(ofSize: fontSize)
            : UIFont.systemFont(ofSize: fontSize)
        // [Border]
        if let borderColor = borderColor {
            btn.layer.borderColor = borderColor.cgColor
            btn.layer.borderWidth = borderWidth
        }
        return btn
    }
    
    func loginButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        // [Title]
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        // [Font]
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        // [Layout]
        btn.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.isEnabled = false
        
        return btn
    }
}


// MARK: - UIView

extension UIView {
    
    // MARK: - Anchor
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeading: CGFloat = 0,
                
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingtrailing: CGFloat = 0,
                
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                centerX: UIView? = nil,
                paddingCenterX: CGFloat = 0,
                
                centerY: UIView? = nil,
                paddingCenterY: CGFloat = 0,
                
                cornerRadius: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingtrailing).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX.centerXAnchor, constant: paddingCenterX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY.centerYAnchor, constant: paddingCenterY).isActive = true
        }
        // cornerRadius
        if let cornerRadius = cornerRadius {
            self.clipsToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leadingAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingleading: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let leading = leadingAnchor {
            anchor(leading: leading, paddingLeading: paddingleading)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor,
               bottom: view.bottomAnchor,
               leading: view.leadingAnchor,
               trailing: view.trailingAnchor)
    }
    
    
    func backgroundColorView(color: UIColor) -> UIView {
        let view = UIView()
            view.backgroundColor = color
        return view
    }
}





enum FontStyle {
    case system
    case bold
}



// MARK: - UILabel
extension UILabel {
    func labelConfig(labelText: String = "",
                     textColor: UIColor = UIColor.black,
                     fontName: FontStyle = .system,
                     fontSize: CGFloat = 12)
    -> UILabel {
        let lbl = UILabel()
        // text
        lbl.text = labelText
        // text Color
        lbl.textColor = textColor
        
        
        // font
        lbl.font = fontName == .bold
            ? UIFont.boldSystemFont(ofSize: fontSize)
            : UIFont.systemFont(ofSize: fontSize)
        return lbl
    }
    
    func profileLabel() -> UILabel {
        let lbl = UILabel()
            lbl.numberOfLines = 0
            lbl.textAlignment = NSTextAlignment.center
        return lbl
    }
}




// MARK: - UIStackView
extension UIStackView {
    
    func stackView(arrangedSubviews: [UIView],
                   axis: NSLayoutConstraint.Axis? = .vertical,
                   spacing: CGFloat? = nil,
                   alignment: UIStackView.Alignment? = nil,
                   distribution: UIStackView.Distribution? = nil)
    -> UIStackView {
        
        let stv = UIStackView(arrangedSubviews: arrangedSubviews)
        
        if let axis = axis {
            stv.axis = axis
        }
        if let distribution = distribution {
            stv.distribution = distribution
        }
        if let spacing = spacing {
            stv.spacing = spacing
        }
        if let alignment = alignment {
            stv.alignment = alignment
        }
        return stv
    }
}




// MARK: - UITextField
extension UITextField {
    func loginTextField(keyboardType: UIKeyboardType,
                        placeholerText: String,
                        isSecure: Bool = false) -> UITextField{
        let tf = UITextField()
        // [사용자 설정]
        if isSecure == true { tf.isSecureTextEntry = true }
        tf.keyboardType = keyboardType
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholerText,
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        
        // [기본 설정]
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
        tf.borderStyle = .none
        tf.textColor = UIColor.white
        tf.keyboardAppearance = .dark
        
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 5
        
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
            // Layout
        let spacer = UIView()
            spacer.setDimensions(height: 50, width: 12)
        tf.leftView = spacer
        tf.leftViewMode = .always
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return tf
    }
    
    
    
    
    
    
    
    
    
    
}




// MARK: - NSMutableAttributedString
extension NSMutableAttributedString {
    
    func attributedText(type1TextString: String,
                        type1FontName: FontStyle = FontStyle.system,
                        type1FontSize: CGFloat = 16,
                        type1Foreground: UIColor = UIColor(white: 1, alpha: 0.7),
                        
                        type2TextString: String,
                        type2FontName: FontStyle = FontStyle.bold,
                        type2FontSize: CGFloat = 16,
                        type2Foreground: UIColor = UIColor(white: 1, alpha: 0.7),
                        
                        type3TextString: String? = nil,
                        type3FontName: FontStyle? = nil,
                        type3FontSize: CGFloat? = nil,
                        type3Foreground: UIColor? = nil
    ) -> NSMutableAttributedString {
        
        // UIFont 설정
        let type1Font: UIFont = type1FontName == FontStyle.system ? UIFont.systemFont(ofSize: type1FontSize) : UIFont.boldSystemFont(ofSize: type1FontSize)
        
        let type2Font: UIFont = type2FontName == FontStyle.system ? UIFont.systemFont(ofSize: type2FontSize) : UIFont.boldSystemFont(ofSize: type2FontSize)
        
        // Mutable_Attributed_String 설정
        let attributedTitle = NSMutableAttributedString(
            string: type1TextString,
            attributes: [NSAttributedString.Key.font : type1Font,
                         NSAttributedString.Key.foregroundColor : type1Foreground]
        )
        attributedTitle.append(NSAttributedString(
            string: type2TextString,
            attributes: [NSAttributedString.Key.font : type2Font,
                         NSAttributedString.Key.foregroundColor : type2Foreground])
        )
        
        // type 3
        if let type3TextString = type3TextString,
           let type3FontName = type3FontName,
           let type3FontSize = type3FontSize,
           let type3Foreground = type3Foreground
        {
            // type 3 - font 설정
            let type3Font: UIFont = type3FontName == FontStyle.system ? UIFont.systemFont(ofSize: type1FontSize) : UIFont.boldSystemFont(ofSize: type3FontSize)
            
            attributedTitle.append(NSAttributedString(
                string: type3TextString,
                attributes: [NSAttributedString.Key.font : type3Font,
                             NSAttributedString.Key.foregroundColor : type3Foreground])
            )
        }
        return attributedTitle
    }
}








// MARK: - UIImageView
extension UIImageView {
    func imageConfig(userInteraction: Bool = false) -> UIImageView {
        let img = UIImageView()
            img.contentMode = UIView.ContentMode.scaleAspectFill
        if userInteraction == true {
            img.isUserInteractionEnabled = true
        }
        return img
    }
}
