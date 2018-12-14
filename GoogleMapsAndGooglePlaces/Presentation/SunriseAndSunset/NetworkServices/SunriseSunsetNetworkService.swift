//
//  SunriseSunsetNetworkService.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import Foundation

struct SunriseSunsetNetworkService: APIClientProtocol {
    
    func fetchSunriseSunset(parameters: ApiParametersProtocol,
                            completion: @escaping (SunriseSunsetResponse?, Error?) -> ()) {
        let request = RequestGenerator<SunriseSunsetResponse>(type: APIRequestType.get,
                                                              encodingType: EncodingType.url,
                                                              endPoint: EndPoint.getSunriseAndSunset,
                                                              parameters: parameters)
        fetch(request: request) { response, error  in
            completion(response, error)
        }
    }
}
