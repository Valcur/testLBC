//
//  Article.swift
//  testLBC
//
//  Created by Loic D on 18/05/2023.
//

import Foundation

struct Article: Codable {
    let id: Int64
    let title: String
    let category_id: Int64
    let creation_date: Date
    let description: String
    let images_url: ArticleImage
    let is_urgent: Bool
    let price: Float
    let siret: String?
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case category_id
        case creation_date
        case description
        case images_url
        case is_urgent
        case price
        case siret
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int64.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        category_id = try container.decode(Int64.self, forKey: .category_id)
        description = try container.decode(String.self, forKey: .description)
        is_urgent = try container.decode(Bool.self, forKey: .is_urgent)
        price = try container.decode(Float.self, forKey: .price)
        siret = try container.decodeIfPresent(String.self, forKey: .siret)
        
        let dateString = try container.decode(String.self, forKey: .creation_date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        creation_date = dateFormatter.date(from: dateString)!
        
        images_url = try container.decode(ArticleImage.self, forKey: .images_url)
    }
    
    init(id: Int64, title: String, category_id: Int64, creation_date: Date, description: String, images_url: ArticleImage, is_urgent: Bool, price: Float, siret: String?) {
        self.id = id
        self.title = title
        self.category_id = category_id
        self.creation_date = creation_date
        self.description = description
        self.images_url = images_url
        self.is_urgent = is_urgent
        self.price = price
        self.siret = siret
    }
    
    struct ArticleImage: Codable {
        let small: String?
        let thumb: String?
    }
}
