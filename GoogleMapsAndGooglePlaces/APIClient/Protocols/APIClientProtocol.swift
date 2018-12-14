//
//  APIClient.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import Alamofire

protocol APIClientProtocol: ProgressShowable {
    func fetch<T: APIRequestProtocol>(request: T, isShowProgressHud: Bool, completion: @escaping (T.ResponseType?,_ error: Error?) -> ())
}

extension APIClientProtocol {
    
    func fetch<T: APIRequestProtocol>(request: T, isShowProgressHud: Bool = true, completion: @escaping (T.ResponseType?,_ error: Error?) -> ()) {
        
        guard let url = request.endPoint.url else { return }
        if isShowProgressHud {
            show()
        }
        
        Alamofire.request(url,method: getHTTPMethod(with: request), parameters: request.parameters?.convertToDictionary(), encoding: getEncoding(with: request), headers: getHeader()).responseData { (calback) in
            
            self.handle(request: request, isCloseProgressHud: isShowProgressHud, callback: calback) { (items, error)  in
                completion(items, error)
            }
        }
    }
}

private extension APIClientProtocol {
    
    func getHeader() -> [String: String]? {
        return nil
    }
    
    func getEncoding<T: APIRequestProtocol>(with request: T) -> ParameterEncoding {
        
        switch request.encodingType {
        case .json:   return  JSONEncoding.default
        case .url :   return  URLEncoding.default
        case .query : return URLEncoding(destination: .queryString)
        }
    }
    
    func getHTTPMethod<T: APIRequestProtocol>(with request: T) -> HTTPMethod {
        switch request.type {
        case .post:   return .post
        case .get:    return .get
        case .put:    return .put
        case .delete: return .delete
        }
    }
    
    func handle<T: APIRequestProtocol>(request: T, isCloseProgressHud: Bool, callback: DataResponse<Data>, completion: (T.ResponseType?, Error?) -> () ) {
        
        if isCloseProgressHud {
            close()
        }
        
        if callback.response?.statusCode == 200 {
            if let data = callback.data {
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let items = try decoder.decode(T.ResponseType.self, from: data)
                    completion(items,nil)
                    
                } catch let error {
                    completion(nil,error)
                }
            } else {
                completion(nil,callback.error)
            }
        } else {
            completion(nil,callback.error)
        }
    }
}






