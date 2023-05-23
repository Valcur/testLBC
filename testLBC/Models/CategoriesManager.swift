//
//  CategoriesManager.swift
//  testLBC
//
//  Created by Loic D on 22/05/2023.
//

import Foundation

struct CategoriesManager {
    let categories: [ArticleCategory]
    
    init(_ cat: [ArticleCategory] = []) {
        categories = cat
    }
    
    func categoryNameforId(_ id: Int64) -> String {
        let id = Int(truncatingIfNeeded: id)
        guard id >= 1 && id <= categories.count else {
            return "Id Error"
        }
        return categories[id - 1].name
    }
}
