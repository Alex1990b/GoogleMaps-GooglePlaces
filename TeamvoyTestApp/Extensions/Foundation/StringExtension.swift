//
//  StringExtension.swift
//  Vixinity
//
//  Created by Sasha on 30.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

extension String {
    
    func UTCToLocal(incomingFormat: String? = "h:mm:ss a", outGoingFormat: String? = "h:mm:ss a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
}

