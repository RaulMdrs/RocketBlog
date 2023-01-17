//
//  ParseJSON.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 27/12/22.
//

import Foundation


protocol GetDelegateProtocol {
    func success(_ response: UserResponse)
    func failed(_ message: String)
}

protocol PostRegisterDelegateProtocol {
    func success(_ response: RegisterResponse)
    func failed(_ message : String)
}

protocol PostLoginDelegateProtocol {
    func success(_ response: LoginResponse)
    func failed(_ message : String)
}

struct ApiManager {
    
    let apiURL = "https://rocket.vortigo.tech"
    let login = "/auth/login"
    let apiHealthStatus = "/health"
    let register = "/register"
    let getMe = "/users/me"
    var registerDelegate: PostRegisterDelegateProtocol?
    var loginDelegate: PostLoginDelegateProtocol?
    var userDelegate: GetDelegateProtocol?
    
    func makePostRegisterRequest(_ user: UserRegister) {
        guard let url = URL(string: apiURL + register) else {
            self.registerDelegate?.failed(K.Intl.errorDefaultErrorMessage)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body : [String : String] = [
            "name": user.name,
            "email": user.email,
            "password": user.password,
            "confirmPassword": user.confirmPassword
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            DispatchQueue.main.async {
                self.registerDelegate?.failed(K.Intl.errorDefaultErrorMessage)
            }
            return
        }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.registerDelegate?.failed(K.Intl.errorDefaultErrorMessage)
                }
                return
            }
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    if response.status == K.ResponseAPI.success {
                        self.registerDelegate?.success(response)
                    } else{
                        self.registerDelegate?.failed(response.errors?[0].msg ?? K.Intl.errorDefaultErrorMessage)
                    }
                }
                catch {
                    self.registerDelegate?.failed(K.Intl.errorDefaultErrorMessage)
                }
            }
        }
        task.resume()
    }
    
    func makePostLoginRequest(_ user: UserLogin) {
        guard let url = URL(string: apiURL + login) else {
            self.loginDelegate?.failed(K.Intl.errorDefaultErrorMessage)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body : [String : String] = [
            "email": user.email,
            "password": user.password
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            DispatchQueue.main.async {
                self.loginDelegate?.failed(K.Intl.errorDefaultErrorMessage)
            }
            return
        }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.loginDelegate?.failed(K.Intl.errorDefaultErrorMessage)
                }
                return
            }
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if response.status == K.ResponseAPI.success {
                        self.loginDelegate?.success(response)
                        
                        guard let token = response.data?.accessToken else {return}
                        Authentication.shared.accessToken = token
                    } else{
                        guard let errorResponseMsg = response.errors?.first?.msg else {return}
                        self.loginDelegate?.failed(errorResponseMsg)
                    }
                }
                catch {
                    self.loginDelegate?.failed(K.Intl.errorDefaultErrorMessage)
                }
            }
        }
        task.resume()
    }
    
    func makeGetMeRequest() {
        guard let url = URL(string: apiURL + getMe) else {
            self.userDelegate?.failed(K.Intl.errorDefaultErrorMessage)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue(Authentication.shared.getToken(), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.userDelegate?.failed(K.Intl.errorDefaultErrorMessage)
                }
                return
            }
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(UserResponse.self, from: data)
                    if response.status == K.ResponseAPI.success {
                        self.userDelegate?.success(response)
                    } else {
                        guard let errorResponseMsg = response.errors?.first?.msg else {return}
                        self.userDelegate?.failed(errorResponseMsg)
                    }
                }
                catch {
                    self.userDelegate?.failed(K.Intl.errorDefaultErrorMessage)
                }
            }
        }
        task.resume()
    }
}
