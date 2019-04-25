//
//  BaseService.swift
//  test Moya
//
//  Created by anhxa100 on 4/25/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import RxSwift

class ResponseError {
    static let invalidJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
}

//  Dùng thông thường
class BaseService {
    static func requestJson(api: API, completion: @escaping ([String: Any]?, Error?) -> ()) {
        APIProvider.shared.request(api) { result in
            do {
                switch result {
                case .success(let response):
                    let json = try response.mapJSON()
                    if let jsonDict = json as? [String: Any] {
                        completion(jsonDict, nil)
                    } else {
                        throw ResponseError.invalidJSONFormat
                    }
                case .failure(let error):
                    throw error
                }
            } catch {
                completion(nil, error)
            }
        }
    }
    
    //Dùng RxSwift
    static func requestJsonRx(api: API) -> Observable<[String: Any]> {
        return Observable.create({observer -> Disposable in
            let request = APIProvider.shared.request(api, completion: {result in
                do {
                    switch result {
                    case .success(let response):
                        let json = try response.mapJSON()
                        if let jsonDist = json as? [String: Any] {
                            observer.onNext(jsonDist)
                            observer.onCompleted()
                        } else {
                            throw ResponseError.invalidJSONFormat
                        }
                    case .failure(let error):
                        throw error
                    }
                }
                catch let error {
                    observer.onError(error)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
}
