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
    
    func getReviewsForShow(
        showId: String,
        authInfo: AuthInfo,
        handler: @escaping (Result<(ReviewResponse), Error>) -> Void
    ){
        AF
            .request(Router.getReviewsForShowId(showId: showId, authInfo: authInfo))
            .validate()
            .responseDecodable(of: ReviewResponse.self){ dataResponse in
                switch dataResponse.result {
                case .success(let reviewResponse):
                    handler(.success(reviewResponse))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
    func postReview(
        comment: String,
        rating: Int,
        showId: Int,
        authInfo: AuthInfo,
        handler: @escaping (Result<(Data?), Error>) -> Void
    ){
        AF
            .request(Router.postReview(comment: comment, rating: rating, showId: showId, authInfo: authInfo))
            .validate()
            .response{ dataResponse in
                switch dataResponse.result {
                case .success(let response):
                    handler(.success(response))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
    func getCurrentLoggedInUser(
        authInfo: AuthInfo,
        handler: @escaping (Result<(UserResponse), Error>) -> Void
    ){
        AF
            .request(Router.getCurrentLoggedInUser(authInfo: authInfo))
            .validate()
            .responseDecodable(of: UserResponse.self){ dataResponse in
                switch dataResponse.result {
                case .success(let user):
                    handler(.success(user))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
}
