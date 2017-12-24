//
//  Config+Server.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import Foundation

struct Config {
    static let serverBaseURL: URL = {
        return URL(string: "https://api.github.com/")!
    }()
}
