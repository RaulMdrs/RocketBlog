//
//  VerifyLoader.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 25/01/23.
//

import Foundation

struct VerifyLoader {
    static var headerRequest = false
    static var forYouRequest = false
    
    static func verifyLoader(loader : LoaderView) {
        if headerRequest && forYouRequest {
            loader.hideLoader()
        }
        else {
            loader.showLoader()
        }
    }
}
