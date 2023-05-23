//
//  testLBCTests.swift
//  testLBCTests
//
//  Created by Loic D on 17/05/2023.
//

import XCTest
@testable import testLBC

final class testLBCTests: XCTestCase {
    
    var articleVM: ArticleViewModel = ArticleViewModel()

    func testArticleVM_Data() throws {
        let exp = expectation(description: "Test if download sucessfull after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(articleVM.categoriesManager.categories.count == 11)
            XCTAssert(articleVM.filteredArticles.count > 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testArticleVM_Filter() throws {
        let exp = expectation(description: "Test if filter sucessfull after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            articleVM.filterForCategory(1)
            
            XCTAssert(articleVM.filteredArticles.count > 0)
            for article in articleVM.filteredArticles {
                XCTAssert(article.category_id == 1)
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
