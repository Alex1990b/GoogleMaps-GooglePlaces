//
//  File.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? { get}
}

extension EndPointProtocol {
    var baseURL: String {
        return ""
    }
}

enum EndPoint: String, EndPointProtocol {
    
    case getSunriseAndSunset = "https://api.sunrise-sunset.org/json?"

    var url: URL? {
        return URL(string: baseURL + self.rawValue)
    }
}



