//
//  ArticleElement.swift
//  testLBC
//
//  Created by Loic D on 22/05/2023.
//

import SwiftUI

extension ArticleView {
    struct ArticleElement: View {
        @Environment(\.colorScheme) var colorScheme
        let article: Article
        let categoriesManager: CategoriesManager
        @State private var image: UIImage? = nil
        @State private var showingDetails = false
        
        var body: some View {
            Button(action: {
                showingDetails.toggle()
            }, label: {
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 15) {
                        // Image
                        if let image = image {
                            GeometryReader { geo in
                                ZStack {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .blur(radius: 20)
                                        .frame(height: 250)
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 250)
                                        
                                }.frame(width: geo.size.width, height: 250).cornerRadius(15)
                            }.frame(height: 250)
                        } else {
                            Color.orange.cornerRadius(15).frame(height: 250)
                        }
                        
                        // Info
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(String(format: "%.2f", article.price) + "€")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                Spacer()
                                Text(categoriesManager.categoryNameforId(article.category_id))
                                    .font(.headline)
                            }
                            
                            Text(article.title)
                        }
                    }
                    if article.is_urgent {
                        Text("Urgent")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .padding(10)
                    }
                }
            }).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .onAppear() {
                if image == nil {
                    loadArticleImage()
                }
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
