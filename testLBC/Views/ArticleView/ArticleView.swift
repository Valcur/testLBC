//
//  ArticleView.swift
//  testLBC
//
//  Created by Loic D on 17/05/2023.
//

import SwiftUI

struct ArticleView: View {
    @EnvironmentObject private var articleVM: ArticleViewModel
    private var categories: [ArticleCategory] {
        articleVM.categoriesManager.categories
    }
    
    private var columns: [GridItem] {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return[
                GridItem(.flexible(), spacing: 35),
                GridItem(.flexible(), spacing: 35)
            ]
        } else {
            return[
                GridItem(.flexible())
            ]
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ScrollView(.vertical) {
                VStack {
                    Text("Nouvelles annonces")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .padding(.vertical, 50)
                    LazyVGrid(columns: columns, spacing: 35) {
                        ForEach(articleVM.filteredArticles, id: \.id) { article in
                            ArticleElement(article: article, categoriesManager: articleVM.categoriesManager)
                        }
                    }.padding(.horizontal, 15).padding(.bottom, 100)
                }
            }
            
            ZStack {
                Color.black
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<categories.count, id: \.self) { i in
                            CategoryFilterElement(category: categories[i])
                        }
                    }.padding(.horizontal, 15)
                }
            }.frame(height: 80).cornerRadius(15).padding(.horizontal, 10)
        }
    }
}
