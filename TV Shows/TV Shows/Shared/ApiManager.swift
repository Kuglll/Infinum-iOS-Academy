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
        handler: @escaping (Result<(UserResponse, [String : String]), Error>) -> Void
    ) {
        AF
            .request(Router.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    let successTuple = (userResponse, headers)
                    handler(.success(successTuple))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
    func loginUserWith(
        email: String,
        password: String,
        handler: @escaping (Result<(UserResponse, [String : String]), Error>) -> Void
    ) {
        AF
            .request(Router.login(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    let successTuple = (userResponse, headers)
                    handler(.success(successTuple))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
}
