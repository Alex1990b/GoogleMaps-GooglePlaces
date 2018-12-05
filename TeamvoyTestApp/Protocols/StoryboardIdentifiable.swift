//
//  StoryboardIdentifiable.swift
//  Vixinity
//
//  Created by Sasha on 29.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
