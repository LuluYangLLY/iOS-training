//
//  FetchService.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/25.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import Foundation

import Alamofire

class FetchService {
    func fetch<T: Decodable>(url: String, completion: @escaping(T)-> Void){
        AF.request(url).responseDecodable(of: T.self) { (response) in
            print(response)
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    
//    private lazy var decoder: JSONDecoder = JSONDecoder()
//
//    public func fetchData<T: Decodable>(url: String, completion: @escaping (T) -> Void) {
//        AF.request(url)
//            .validate(statusCode: [200])
//            .responseData { response in
//                switch response.result {
//                case let .success(data):
//                    guard let decoderesult: T = self.decode(of: data) else {return}
//
//                    DispatchQueue.main.async {
//                        completion(decoderesult)
//                    }
//                case let .failure(error):
//                    debugPrint(error)
//                }
//        }
//    }
//
//    private func decode<T: Decodable>(of data: Data) -> T? {
//        var defaultResult:T? = nil
//
//        do {
//            defaultResult = try decoder.decode(T.self, from: data)
//        } catch let ex {
//            debugPrint(ex)
//        }
//
//        return defaultResult
//    }
}
