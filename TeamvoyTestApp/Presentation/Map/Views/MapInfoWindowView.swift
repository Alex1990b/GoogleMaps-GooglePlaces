//
//  MapInfoWindowView.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

final class MapInfoWindowView: UIView, NibLoadableView {
    
    @IBOutlet private weak var placeNameLabel: UILabel!
    @IBOutlet private weak var placeAdressLabel: UILabel!
    
    static func instanceFromNib() -> UIView {
        return UINib(nibName: self.nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setFrame()
    }
    
    var place: Place? {
        didSet {
            placeNameLabel.text = place?.name
            placeAdressLabel.text = place?.adress
        }
    }
}

private extension MapInfoWindowView {
    func setFrame() {
        frame =  CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
    }
}
