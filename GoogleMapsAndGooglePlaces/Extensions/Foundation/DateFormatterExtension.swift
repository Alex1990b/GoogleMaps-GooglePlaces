//
//  DateFormatterExtension.swift
//  TeamvoyTestApp
//
//  Created by Sasha on 14.12.18.
//  Copyright © 2018 alex. All rights reserved.
//


import Foundation

enum DateFormatType: String {
    case hmmss_a = "h:mm:ss a"
}

extension DateFormatter {
    
    static var dateFormatter = DateFormatter()
    
    static func dateFormatter(with format: DateFormatType) -> DateFormatter {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter
    }
}
