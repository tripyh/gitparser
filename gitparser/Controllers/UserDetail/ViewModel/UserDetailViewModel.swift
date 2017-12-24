//
//  UserDetailViewModel.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import Foundation

class UserDetailViewModel: NSObject {
    
    // MARK: Internal properties
    let user: MDUser
    
    // MARK: Lifecycle
    init(user: MDUser) {
        self.user = user
    }
}
