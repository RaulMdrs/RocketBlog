//
//  APIpath.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 05/01/23.
//

import Foundation

struct ApiPath {
    private static let apiURL = "https://rocket.vortigo.tech"
    private static let apiHealthStatus : String = "/health"
    private static let register : String = "/register"
    private static let login : String = "/auth/login"
    private static let getMe : String = "/users/me"
    private static let userPost : String = "/posts/featured"
    private static let people : String = "/users/featured"
    
    static func apiRegisterPath() -> String {
        "\(self.apiURL)\(self.register)"
    }
    
    static func apiLoginPath() -> String {
        "\(self.apiURL)\(self.login)"
    }
    
    static func apiGetMePath() -> String {
        "\(self.apiURL)\(self.getMe)"
    }
    
    static func apiUserPostPath() -> String {
        "\(self.apiURL)\(self.userPost)"
    }
    
    static func apiPeoplePath() -> String {
        "\(self.apiURL)\(self.people)"
    }
}
