//
//  StringExtension.swift
//  Vixinity
//
//  Created by Sasha on 30.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

extension String {
    
    func UTCToLocal(incomingFormat: DateFormatType = DateFormatType.hmmss_a,
                    outGoingFormat: DateFormatType = DateFormatType.hmmss_a) -> String {
        
        let dateFormatter = DateFormatter.dateFormatter(with: incomingFormat)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat.rawValue
        
        return dateFormatter.string(from: date ?? Date())
    }
}

