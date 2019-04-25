//
//  APIStructure.swift
//  test Moya
//
//  Created by anhxa100 on 4/25/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Moya

enum API {
    case getPass
    
}

extension API: TargetType {
    
    static let baseURL = "https://dzodzo.com.vn"
    static let apiVersion = "/a/api"
    
    var baseURL: URL {
        return URL(string: API.baseURL +  API.apiVersion)!
    }
    
    var path: String {
        switch self {
        case .getPass:
            return "get pass"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPass:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getPass:
            return Task.requestPlain
        
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}


class APIProvider {
    static let shared = MoyaProvider<API>()
    
}
