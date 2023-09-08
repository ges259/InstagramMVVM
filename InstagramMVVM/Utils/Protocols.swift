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
}



// [UploadPostController]
protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}



//
protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowCommentFor post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
}


//
protocol CommentInputAccessoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentAccessoryView, wantsToUploadComment comment: String)
}







