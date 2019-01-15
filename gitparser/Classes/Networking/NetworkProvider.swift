//
//  NetworkProvider.swift
//  gitparser
//
//  Created by andrey rulev on 12/24/17.
//  Copyright © 2017 andrey rulev. All rights reserved.
//

import Moya
import ReactiveSwift

protocol NetworkTarget: TargetType {
    
}

extension NetworkTarget {
    var baseURL: URL {
        return Config.serverBaseURL
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [:]
    }
}
