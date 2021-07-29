//
//  Router.swift
//  TV Shows
//
//  Created by Mark Frelih on 18.07.2021..
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible{
    
    case register(email: String, password: String)
    case login(email: String, password: String)
    
    var path: String {
        switch self {
        case .register:
            return "users/"
        case .login:
            return "users/sign_in"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .register(let email, let password):
            return [
                "email": email,
                "password": password,
                "password_confirmation": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password,
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try URL(string: Constants.API.baseUrl.asURL()
                                                  .appendingPathComponent(path)
                                                  .absoluteString.removingPercentEncoding!)
        var request = URLRequest.init(url: url!)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10*1000)
        return try URLEncoding.default.encode(request,with: parameters)
    }
    
    
}
