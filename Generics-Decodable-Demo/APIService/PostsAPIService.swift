//
//  PostsAPIService.swift
//  Generics-Decodable-Demo
//
//  Created by Hassan Mostafa on 7/28/19.
//  Copyright © 2019 Minds. All rights reserved.
//

import Foundation
import Alamofire

class PostsAPIService {
    // singletone
    static let instance = PostsAPIService()
    func getPosts(url: String, completion: @escaping ([PostsModel]?, Error?)->Void) {
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else { return }
            switch response.result {
            case .success(let val):
                do {
                  let posts = try JSONDecoder().decode([PostsModel].self, from: data)
                    completion(posts, nil)
                } catch let jsonError{
                   print(jsonError)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func getData<T: Decodable>(url: String, completion: @escaping (T?, Error?)->Void) {
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else { return }
            switch response.result {
            case .success(let val):
                do {
                    let posts = try JSONDecoder().decode(T.self, from: data)
                    completion(posts, nil)
                } catch let jsonError{
                    print(jsonError)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
