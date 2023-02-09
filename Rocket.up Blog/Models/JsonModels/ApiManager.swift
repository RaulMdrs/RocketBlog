import Foundation

protocol RequestDelegate {
    func success<T>(_ response: T)
    func errorMessage(_ message: String)
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

struct ApiManager {
    var requestDelegate: RequestDelegate?
    
    func genericRequest <T: Codable> (model: T.Type, path: String, method: Method, header: [String : String], body: [String : String]?) {
        
        guard let url = URL(string: path) else {
            self.requestDelegate?.errorMessage(K.Intl.errorDefaultErrorMessage)
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        for item in header {
    
            request.addValue(item.value, forHTTPHeaderField: item.key)
        }
           if let body = body {
            guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                DispatchQueue.main.async {
                    requestDelegate?.errorMessage(K.Intl.errorDefaultErrorMessage)
                }
                return }
            request.httpBody = bodyData
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    requestDelegate?.errorMessage(K.Intl.errorDefaultErrorMessage)
                }
                return }
            
            DispatchQueue.main.async {
                do {
                    let statusResponse = try JSONDecoder().decode(GenericResponse.self, from: data)
                    if statusResponse.status == K.ResponseAPI.success {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        self.requestDelegate?.success(response)
                    } else{
                        self.requestDelegate?.errorMessage(statusResponse.errors?.msg ?? K.Intl.errorDefaultErrorMessage)
                    }
                }
                catch {
                    self.requestDelegate?.errorMessage(K.Intl.errorDefaultErrorMessage)
                }
            }
        }
        task.resume()
    }
}

