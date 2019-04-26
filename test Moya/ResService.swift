//
//  resService.swift
//  test Moya
//
//  Created by anhxa100 on 4/25/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import RxSwift

class ResService: BaseService {
    static func getPass(id: Int, completion: @escaping (Account?, Error?) -> ()) {
        requestJson(api: .getPass, completion: {(json, error) in
            if let error = error {
                completion(nil, error)
            } else if let res = Account(json: JSON) {
                completion(Account(json: JSON), nil)
            } else {
                completion(nil, ResponseError.invalidJSONFormat)
            }
        })
    }
    // Sử dụng RxSwift
    static func getPassRxSwift(id: Int) -> Observable<Account> {
        return requestJsonRx(api: .getPass).map({json in
            if let resChoosse = Account(json: JSON) {
                return resChoosse
            } else {
                throw ResponseError.invalidJSONFormat
            }
        })
    }
    
}
