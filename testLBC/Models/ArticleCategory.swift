//
//  ArticleCategory.swift
//  testLBC
//
//  Created by Loic D on 18/05/2023.
//

import Foundation

struct ArticleCategory: Codable {
    let id: Int64
    let name: String
}

struct Categories {
    let categories: [ArticleCategory]
    
    init(_ cat: [ArticleCategory] = []) {
        categories = cat
    }
    
    func categoryNameforId(_ id: Int64) -> String {
        let id = Int(id)
        guard id >= 1 && id <= categories.count else {
            return "Id Error"
        }
        return categories[id - 1].name
    }
}
