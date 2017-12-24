//
//  MDUser.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import Foundation

struct MDUser {
    let id: Int
    let login: String
    let avatarUrl: String?
    
    init(id: Int,
         login: String,
         avatarUrl: String?) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
    }
}

// MARK: Decodable
extension MDUser: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let login = try container.decode(String.self, forKey: .login)
        let avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.init(id: id, login: login, avatarUrl: avatarUrl)
    }
}
