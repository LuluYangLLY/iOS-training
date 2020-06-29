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
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func fetchImage(urlString: String, imageView: UIImageView) {
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]{
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    //print("using image cache")
                    let image = UIImage(data: data)
                    imageView.image = image
                } else {
                    self.fetchImageFromRemote(urlString: urlString, imageView: imageView)
                }
            }
        } else {
            self.fetchImageFromRemote(urlString: urlString, imageView: imageView)
        }
    }
    
    private func fetchImageFromRemote(urlString: String, imageView: UIImageView){
        AF.download(urlString).responseData { response in
            if let data = response.value {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.storeImage(urlString: urlString, image: image)
                        imageView.image = image
                    }
                }
            }
        }
    }
    
    // ImageCache: Using "UserDefaults"
    // Learned from "iOS/Swift 5-minute Tips: Easy Image Cache In Swift"
    // https://www.youtube.com/watch?v=VWLYaZc0Ol0
    private func storeImage(urlString: String, image: UIImage){
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = image.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
        if dict == nil {
            dict = [String: String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
}
