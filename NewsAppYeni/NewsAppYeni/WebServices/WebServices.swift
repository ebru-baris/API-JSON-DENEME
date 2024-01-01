//
//  WebServices.swift
//  NewsAppYeni
//
//  Created by Ebru Barış on 1.01.2024.
//

import Foundation

class WebServices {
    static let shared = WebServices()
    private init() {}
    
    func fetchNews(completion: @escaping ([Model]?) -> Void){
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ae3cea9f9152494e8d107deb4a72ce7d"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    do {
                        let result = try JSONDecoder().decode(NewResponse.self, from: data!)
                        completion(result.articles)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
