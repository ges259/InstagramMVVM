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
protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}
// profileHeader
protocol ProfileHeaderDelegate: AnyObject {
    func header(_ profileHeader: ProfileHeader, didTapActionBtnFor user: User)
//    func header(_ profileHeader: ProfileHeader, wantsToUnFollow uid: String)
//    func headerWantsToShowEditProfile(_ profileHeader: ProfileHeader)
}



// [UploadPostController]
protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}












