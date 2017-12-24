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
    var additionalHeaders: [String: String] { get }
}

extension NetworkTarget {
    var baseURL: URL {
        return Config.serverBaseURL
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var additionalHeaders: [String: String] {
        return [:]
    }
}

class NetworkProvider<Target>: ReactiveSwiftMoyaProvider<Target> where Target: NetworkTarget {
    init() {
        super.init(
            endpointClosure: NetworkProvider.customEndpointMapping,
            requestClosure: MoyaProvider.defaultRequestMapping,
            stubClosure: MoyaProvider.neverStub,
            manager: MoyaProvider<Target>.defaultAlamofireManager(),
            plugins: [],
            stubScheduler: nil,
            trackInflights: false
        )
    }
    
    func req(_ target: Target) -> SignalProducer<Response, MoyaError> {
        return request(target).filterSuccessfulStatusCodes().observe(on: UIScheduler())
    }
    
    private final class func customEndpointMapping<T>(target: T) -> Endpoint<T> where T: NetworkTarget {
        let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
        
        
        if !target.additionalHeaders.isEmpty {
            return endpoint.adding(newHTTPHeaderFields: target.additionalHeaders)
        } else {
            return endpoint
        }
    }
}

