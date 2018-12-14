//
//  UINavigationBarExtension.swift
//  TeamvoyTestApp
//
//  Created by Alex on 05.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
