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
    case postReview(comment: String, rating: Int, showId: Int, authInfo: AuthInfo)
    case getCurrentLoggedInUser(authInfo: AuthInfo)
    case uploadImage(email: String, authInfo: AuthInfo)
    
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
        case .postReview:
            return "reviews"
        case .getCurrentLoggedInUser:
            return "users/me"
        case .uploadImage:
            return "users"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .register, .login, .postReview:
            return .post
        case .listShows, .getReviewsForShowId, .getCurrentLoggedInUser:
            return .get
        case .uploadImage:
            return .put
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
        case .postReview(let comment, let rating, let showId, _):
            return [
                "comment": comment,
                "rating": rating,
                "show_id": showId
            ]
        case .getCurrentLoggedInUser:
            return nil
        case .uploadImage(let email, _):
            return [
                "email": email
            ]
        }
    }
    
    var headers: [String:String]?{
        switch self{
        case .register, .login:
            return nil
        case .listShows(let authInfo),
             .getReviewsForShowId(_, let authInfo),
             .postReview(_, _, _, let authInfo),
             .getCurrentLoggedInUser(let authInfo),
             .uploadImage(_, let authInfo):
            return authInfo.headers
        }
    }
        
    
    var enconding: ParameterEncoding{
        switch self {
        case .register, .login, .postReview, .uploadImage:
            return JSONEncoding.default
        case .listShows, .getReviewsForShowId, .getCurrentLoggedInUser:
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
