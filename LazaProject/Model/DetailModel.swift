//
//  DetailModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import Foundation

struct Detail: Codable {
    let status: String
    let isError: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let name, description: String
    let imageURL: String
    let price, brandID: Int
    let category: Category
    let size: [Sizes]
    let reviews: [Review]
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageURL = "image_url"
        case price
        case brandID = "brand_id"
        case category, size, reviews
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let category: String
}

// MARK: - Review
struct Review: Codable {
    let id: Int
    let comment: String
    let rating: Double
    let fullName: String
    let imageURL: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, rating
        case fullName = "full_name"
        case imageURL = "image_url"
        case createdAt = "created_at"
    }
}

struct ReviewData: Codable {
    let status: String
    let isError: Bool
    let data: Reviews
}

struct Reviews: Codable {
    let ratingAvrg: Double
    let total: Int
    let reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case ratingAvrg = "rating_avrg"
        case total, reviews
    }
}

struct ReviewSuccess: Codable {
    let status: String
    let isError: Bool
    let data: ReviewDataSuccess
}

// MARK: - DataClass
struct ReviewDataSuccess: Codable {
    let id: Int
    let comment: String
    let rating: Double
    let createdAt: String
    let userID, productID: Int

    enum CodingKeys: String, CodingKey {
        case id, comment, rating
        case createdAt = "created_at"
        case userID = "user_id"
        case productID = "product_id"
    }
}
