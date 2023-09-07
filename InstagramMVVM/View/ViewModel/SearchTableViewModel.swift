//
//  SearchTableViewModel.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/07.
//

import Foundation

struct SearchTableViewModel {
    
    private let user: User
    
    
    var profileImgUrl: URL? { return URL(string: self.user.profileImgUrl) }
    
    var userName: String? { return self.user.userName }
    
    var fullName: String? { return self.user.fullName }
    
    
    
    
    init(user: User) {
        self.user = user
    }
}
