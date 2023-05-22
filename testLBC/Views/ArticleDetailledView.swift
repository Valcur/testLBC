//
//  ArticleDetailledView.swift
//  testLBC
//
//  Created by Loic D on 21/05/2023.
//

import SwiftUI

struct ArticleDetailledView: View {
    @State private var image: UIImage? = nil
    let article: Article
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Color.orange
                }
                Color.white.frame(height: 50).cornerRadius(25).offset(y: 25)
            }
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(article.creation_date, style: .date)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                ScrollView(.vertical) {
                    VStack {
                        Text(article.description)
                        Spacer()
                    }
                }
            }.padding(.horizontal, 20).offset(y: -10)

            HStack {
                Spacer()
                Text(String(format: "%.2f", article.price) + "€")
                    .fontWeight(.bold)
                    .padding(.trailing, 20)
                
                Button(action: {}, label: {
                    Text("Add to cart")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(10)
                })
            }.padding(.vertical, 10).padding(.horizontal, 20)
        }
        .onAppear() {
            if image == nil {
                loadArticleImage()
            }
        }
    }
    
    func loadArticleImage() {
        guard let url = URL(string: article.images_url.thumb ?? "") else { return }
        
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
