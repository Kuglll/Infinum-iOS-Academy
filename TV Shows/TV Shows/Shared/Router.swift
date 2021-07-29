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
    
    var enconding: ParameterEncoding{
        switch self {
        case .register, .login:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.baseUrl.asURL().appendingPathComponent(path)
        var request = try URLRequest.init(url: url, method: method)
        request.timeoutInterval = TimeInterval(10*1000)
    
        return try enconding.encode(request, with: parameters)
    }
    
    
}
