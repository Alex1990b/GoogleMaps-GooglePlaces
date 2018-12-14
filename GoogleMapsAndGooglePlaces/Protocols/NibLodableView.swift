//
//  NibLodableView.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}
