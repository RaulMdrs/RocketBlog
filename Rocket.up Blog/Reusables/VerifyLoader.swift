//
//  VerifyLoader.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 25/01/23.
//

import Foundation

struct VerifyLoader {
    static var headerRequest = false
    static var secondRequest = false
    
    static func verifyLoader(loader : LoaderView) {
        if headerRequest && secondRequest{
            loader.hideLoader()
        }
        else {
            loader.showLoader()
        }
    }
}
