//
//  CategoriesTest.swift
//  testLBCTests
//
//  Created by Loic D on 18/05/2023.
//

import XCTest
@testable import testLBC

final class CategoriesTest: XCTestCase {
    
    var categories: Categories = Categories()
    
    override func setUpWithError() throws {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "TestCategories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult = try? JSONDecoder().decode([ArticleCategory].self, from: data) {
                    self.categories = Categories(jsonResult)
                } else {
                    print("Error initalizing Categories from JSON")
                }
            } catch {
                print("Error initalizing CategoriesTest")
            }
        }
    }
    
    func testExample() throws {
        XCTAssert(categories.categories.count == 11)
        for i in 1...11 {
            XCTAssert(categories.categoryNameforId(Int64(i)) != "Id Error")
        }
    }
}
