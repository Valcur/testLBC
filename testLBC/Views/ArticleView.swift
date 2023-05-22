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
    
    var columns: [GridItem] {
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
        VStack {
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<categories.count, id: \.self) { i in
                            CategoryFilterElement(category: categories[i])
                        }
                    }.padding(.leading, 15)
                }
            }.frame(height: 80)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 35) {
                    ForEach(articleVM.filteredArticles, id: \.id) { article in
                        ArticleElement(article: article, categoriesManager: articleVM.categoriesManager)
                    }
                }.padding(.horizontal, 15)
            }
        }
    }
    
    struct CategoryFilterElement: View {
        @EnvironmentObject var articleVM: ArticleViewModel
        let category: ArticleCategory
        var isSelected: Bool {
            return articleVM.filterSelectedId == category.id
        }
        
        var body: some View {
            Button(action: {
                articleVM.filterForCategory(category.id)
            }, label: {
                Text(category.name)
                    .foregroundColor(isSelected ? .orange : .white)
                    .padding()
                    .background(ZStack {
                        if isSelected {
                            Color.white
                        } else {
                            Color.orange
                        }
                    }.cornerRadius(10))
            })
        }
    }
    
    struct ArticleElement: View {
        let article: Article
        let categoriesManager: CategoriesManager
        @State private var image: UIImage? = nil
        @State private var showingDetails = false
        
        var body: some View {
            ZStack {
                VStack {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .frame(height: 250)
                    } else {
                        Color.orange.cornerRadius(15).frame(height: 250)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(String(format: "%.2f", article.price) + "€")
                                .fontWeight(.bold)
                            Spacer()
                            Text(categoriesManager.categoryNameforId(article.category_id))
                        }.padding(.horizontal, 10)
                        
                        Text(article.title)
                    }
                }
                if article.is_urgent {
                    ZStack {
                        Color.orange.cornerRadius(15)
                        Text("Urgent")
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 30)
                    .position(x: 45, y: 30)
                }
            }
            .onAppear() {
                if image == nil {
                    loadArticleImage()
                }
            }
            .onTapGesture {
                showingDetails.toggle()
            }
            .sheet(isPresented: $showingDetails) {
                ArticleDetailledView(article: article)
            }
        }
        
        func loadArticleImage() {
            guard let url = URL(string: article.images_url.small ?? "") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
