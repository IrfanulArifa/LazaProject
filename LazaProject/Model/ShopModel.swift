//
//  ShopModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import Foundation

typealias Welcome = [String] // MARK: Category Model
typealias WelcomeProduct = [WelcomeElement] // MARK: Product Model
typealias UserData = [UserElement] // MARK: User Model

// MARK: All Data in Product Model
struct WelcomeElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

// MARK: CodingKey for JSON Matching
enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

// MARK: All Data in User Model
struct UserElement: Codable {
    let address: Address
    let id: Int
    let email, username, password: String
    let name: Name
    let phone: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case address, id, email, username, password, name, phone
        case v = "__v"
    }
}

// MARK: All data in Address
struct Address: Codable {
    let geolocation: Geolocation
    let city, street: String
    let number: Int
    let zipcode: String
}

// MARK: Geolocation
struct Geolocation: Codable {
    let lat, long: String
}

// MARK: Name
struct Name: Codable {
    let firstname, lastname: String
}


