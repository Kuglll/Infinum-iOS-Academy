//
//  ApiManager.swift
//  TV Shows
//
//  Created by Mark Frelih on 18.07.2021..
//

import Foundation
import SVProgressHUD
import Alamofire

class ApiManager {
    
    static let instance = ApiManager()
    
    func alamofireCodableRegisterUserWith(
        email: String,
        password: String,
        success:@escaping (UserResponse, [String : String]?) -> Void,
        failure:@escaping (String) -> Void
    ) {
        AF
            .request(Router.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    success(userResponse, dataResponse.response?.headers.dictionary)
                case .failure(let error):
                    failure(error.errorDescription ?? "")
                }
            }
    }
    
    func loginUserWith(
        email: String,
        password: String,
        success:@escaping (UserResponse, [String : String]?) -> Void,
        failure:@escaping (String) -> Void
    ) {
        AF
            .request(Router.login(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    success(userResponse, dataResponse.response?.headers.dictionary)
                case .failure(let error):
                    failure(error.errorDescription ?? "")
                }
            }
    }
    
}
