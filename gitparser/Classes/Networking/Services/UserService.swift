//
//  UserService.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import Moya

enum UserService: NetworkTarget {
    case contributors
    
    var path: String {
        return "repos/videolan/vlc/contributors"
    }
    
    var method: Moya.Method {
        return .get
    }
}


