//
//  CategoryFilterElement.swift
//  testLBC
//
//  Created by Loic D on 22/05/2023.
//

import SwiftUI

extension ArticleView {
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
                    .foregroundColor(isSelected ? .white : .white)
                    .padding()
                    .background(ZStack {
                        if isSelected {
                            Color.orange
                        } else {
                            Color("CategoryButtonColor")
                        }
                    }.cornerRadius(10))
            })
        }
    }
}
