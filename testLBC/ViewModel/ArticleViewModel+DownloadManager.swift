//
//  ArticleViewModel+DownloadManager.swift
//  testLBC
//
//  Created by Loic D on 21/05/2023.
//

import Foundation

extension ArticleViewModel {
    static func  fetchArticles(completion: @escaping ([Article]?, Error?) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            if let jsonResult = try? JSONDecoder().decode([Article].self, from: data) {
                completion(jsonResult, nil)
            } else {
                print("Error initalizing Articles from JSON")
                //completion(nil, Error)
            }
        }
        task.resume()
    }
    
    static func  fetchCategories(completion: @escaping ([ArticleCategory]?, Error?) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            if let jsonResult = try? JSONDecoder().decode([ArticleCategory].self, from: data) {
                completion(jsonResult, nil)
            } else {
                print("Error initalizing Categories from JSON")
                //completion(nil, Error)
            }
        }
        task.resume()
    }
}
