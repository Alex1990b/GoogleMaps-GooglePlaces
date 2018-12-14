//
//  MapInfoWindowView.swift
//  TeamvoyTestApp
//
//  Created by Alex on 04.12.18.
//  Copyright © 2018 alex. All rights reserved.
//

import UIKit

final class MapInfoWindowView: UIView, NibLoadableView {
    
    //MARK:  @IBOutlets
    
    @IBOutlet private weak var placeNameLabel: UILabel!
    @IBOutlet private weak var placeAdressLabel: UILabel!
    
    static func instanceFromNib() -> UIView {
        return UINib(nibName: self.nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setFrame()
    }
    
    //MARK:  Variables
    
    var place: Place? {
        didSet {
            placeNameLabel.text = place?.name
            placeAdressLabel.text = place?.address
        }
    }
}

//MARK:  Private methods

private extension MapInfoWindowView {
    func setFrame() {
        frame =  CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
    }
}
