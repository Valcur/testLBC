//
//  ArticleTest.swift
//  testLBCTests
//
//  Created by Loic D on 20/05/2023.
//

import XCTest
@testable import testLBC

final class ArticleTest: XCTestCase {
    
    var articles: [Article] = []
    
    override func setUpWithError() throws {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "TestArticles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult = try? JSONDecoder().decode([Article].self, from: data) {
                    articles = jsonResult
                } else {
                    print("Error initalizing Categories from JSON")
                }
            } catch {
                print("Error initalizing CategoriesTest")
            }
        }
    }
    
    
    func testArticlesJSON() throws {
        XCTAssert(articles[0].id == 1461267313)
    }
}
