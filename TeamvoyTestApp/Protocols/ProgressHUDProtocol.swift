//
//  ProgressHUDProtocol.swift
//  Vixinity
//
//  Created by Sasha on 29.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import SVProgressHUD

protocol ProgressHudProtocol {
    func show()
    func close()
}

extension ProgressHudProtocol {
    func show() {
        SVProgressHUD.show()
    }
    
    func close() {
        SVProgressHUD.dismiss()
    }
}
