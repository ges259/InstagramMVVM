//
//  AuthenticationViewModel.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return self.email?.isEmpty == false && self.password?.isEmpty == false
    }
    
    var btnBackgroundColor: UIColor {
        return self.formIsValid
        ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    var btnTitleColor: UIColor {
        return self.formIsValid
        ? UIColor.white
        : UIColor(white: 1, alpha: 0.67)
    }
}


struct RegisterationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
    
    
    
    
    
    
    var formIsValid: Bool {
        return self.email?.isEmpty == false
            && self.password?.isEmpty == false
            && self.fullName?.isEmpty == false
            && self.userName?.isEmpty == false
    }
    
    var btnBackgroundColor: UIColor {
        return self.formIsValid
        ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    var btnTitleColor: UIColor {
        return self.formIsValid
        ? UIColor.white
        : UIColor(white: 1, alpha: 0.67)
    }
    
    
}
