//
//  Protocols.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit

// [Authentication_ViewModel]
protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var btnBackgroundColor: UIColor { get }
    var btnTitleColor: UIColor { get }
}
protocol FormViewMocel {
    func updateForm()
}












