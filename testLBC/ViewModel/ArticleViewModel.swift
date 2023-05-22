//
//  ArticleViewModel.swift
//  testLBC
//
//  Created by Loic D on 21/05/2023.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var categoriesManager: CategoriesManager = CategoriesManager([])
    @Published var articles: [Article] = [] 
    @Published var filteredArticles: [Article] = []
    @Published var filterSelectedId: Int64 = 0
    
    init() {
        ArticleViewModel.fetchArticles { (art, error) in
            if (error == nil) {
                DispatchQueue.main.async {
                    self.iniArticles(withArticles: art ?? [])
                }
            }
        }
        
        ArticleViewModel.fetchCategories { (cat, error) in
            if (error == nil) {
                DispatchQueue.main.async {
                    self.categoriesManager = CategoriesManager(cat ?? [])
                }
            }
        }
    }
    
    private func iniArticles(withArticles: [Article]) {
        var urgent: [Article] = []
        var nonUrgent: [Article] = []
        
        for article in withArticles {
            if article.is_urgent {
                urgent.append(article)
            } else {
                nonUrgent.append(article)
            }
        }
        
        self.articles = urgent.sorted(by: { $0.creation_date.compare($1.creation_date) == .orderedDescending })
        self.articles += nonUrgent.sorted(by: { $0.creation_date.compare($1.creation_date) == .orderedDescending })
        
        self.filteredArticles = self.articles
    }
    
    func filterForCategory(_ catId: Int64) {
        if catId == filterSelectedId {
            filterSelectedId = 0
            filteredArticles = articles
            return
        }
        
        filterSelectedId = catId
        filteredArticles = articles.filter({ $0.category_id == catId })
    }
}
