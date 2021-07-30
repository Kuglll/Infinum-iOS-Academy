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
        call(router: Router.register(email: email, password: password), handler: handler)
    }
    
    func loginUserWith(
        email: String,
        password: String,
        handler: @escaping (Result<(UserResponse, [String : String]), Error>) -> Void
    ) {
        call(router: Router.login(email: email, password: password), handler: handler)
    }
    
    func call<Model: Decodable>(
            router: URLRequestConvertible,
            handler: @escaping (Result<(Model, [String : String]), Error>) -> Void
        ) {
            AF
                .request(router)
                .validate()
                .responseDecodable(of: Model.self) { dataResponse in
                    switch dataResponse.result {
                    case .success(let response):
                        let headers = dataResponse.response?.headers.dictionary ?? [:]
                        let successTuple = (response, headers)
                        handler(.success(successTuple))
                    case .failure(let error):
                        handler(.failure(error))

                    }
                }
        }
    
    func getShowsList(
        authInfo: AuthInfo,
        handler: @escaping (Result<(ShowsResponse), Error>) -> Void
    ){
        AF
            .request(Router.listShows(authInfo: authInfo))
            .validate()
            .responseDecodable(of: ShowsResponse.self){ dataResponse in
                switch dataResponse.result {
                case .success(let showsResponse):
                    handler(.success(showsResponse))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
}
