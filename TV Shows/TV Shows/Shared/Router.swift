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
    case listShows(authInfo: AuthInfo)
    case getReviewsForShowId(showId: String, authInfo: AuthInfo)
    
    var path: String {
        switch self {
        case .register:
            return "users/"
        case .login:
            return "users/sign_in"
        case .listShows:
            return "shows"
        case .getReviewsForShowId(let showId, _):
            return "shows/\(showId)/reviews"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .register, .login:
            return .post
        case .listShows, .getReviewsForShowId:
            return .get
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
        case .listShows:
            return [
                "page": "1",
                "items": "100"
            ]
        case .getReviewsForShowId:
            return [
                "page": "1",
                "items": "10"
            ]
        }
    }
    
    var headers: [String:String]?{
        switch self{
        case .register, .login:
            return nil
        case .listShows(let authInfo), .getReviewsForShowId(_, let authInfo):
            return authInfo.headers
        }
    }
        
    
    var enconding: ParameterEncoding{
        switch self {
        case .register, .login:
            return JSONEncoding.default
        case .listShows, .getReviewsForShowId:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.baseUrl.asURL().appendingPathComponent(path)
        var request = try URLRequest.init(url: url, method: method)
        if let unwrappedHeaders = headers{
            request.headers = HTTPHeaders(unwrappedHeaders)
        }
        request.timeoutInterval = TimeInterval(10*1000)
    
        return try enconding.encode(request, with: parameters)
    }
    
    
}
