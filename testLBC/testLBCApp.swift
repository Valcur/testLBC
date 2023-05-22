//
//  testLBCApp.swift
//  testLBC
//
//  Created by Loic D on 17/05/2023.
//

import SwiftUI

@main
struct testLBCApp: App {
    var body: some Scene {
        WindowGroup {
            ArticleView()
                .environmentObject(ArticleViewModel())
        }
    }
}
