//
//  ParseJSON.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 27/12/22.
//

import Foundation


protocol GetDelegateProtocol {
    func success()
    func failed()
}

protocol PostDelegateProtocol {
    func success(_ response: Response)
    func failed(_ message : String)
}

struct ParseJSON {
    
    let apiURL = "https://rocket.vortigo.tech"
    let login = "/auth/login"
    let apiHealthStatus = "/health"
    let register = "/register"
    
    var delegate : PostDelegateProtocol?
    
    func makePostRequest(_ user: User) {
        guard let url = URL(string: apiURL + register) else {
            self.delegate?.failed(K.ErrorLabel.defaultErrorMessage)
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
               self.delegate?.failed(K.ErrorLabel.defaultErrorMessage)
           }
           return
       }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.delegate?.failed(K.ErrorLabel.defaultErrorMessage)
                }
                return
            }
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    if response.status == K.ResponseAPI.success {
                        self.delegate?.success(response)
                    } else{
                        self.delegate?.failed(response.errors?[0].msg ?? K.ErrorLabel.defaultErrorMessage)
                    }
                }
                catch {
                    self.delegate?.failed(K.ErrorLabel.defaultErrorMessage)
                }
            }
        }
        task.resume()
    }
    

}
