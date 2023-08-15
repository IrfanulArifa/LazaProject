//
//  ShopModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import Foundation

struct Welcome: Codable {
  let status: String
  let isError: Bool
  let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
  let id: Int
  let name, imageURL: String
  let price: Double
  let createdAt: String
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case imageURL = "image_url"
    case price
    case createdAt = "created_at"
  }
}

// MARK: - Brand
struct Brand: Codable {
  let status: String
  let isError: Bool
  let description: [Description]
}

// MARK: - Description
struct Description: Codable {
  let id: Int
  let name, logoURL: String
  let deletedAt: JSONNull?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case logoURL = "logo_url"
    case deletedAt = "deleted_at"
  }
}

class JSONNull: Codable, Hashable {
  
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }
  
  public var hashValue: Int {
    return 0
  }
  
  public init() {}
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}

typealias UserData = [UserElement] // MARK: User Model

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

struct Size: Codable {
  let status: String
  let isError: Bool
  let data: [Sizes]
}

// MARK: - Data
struct Sizes: Codable {
  let id: Int
  let size: String
}

struct ResponseSignUpFailed: Codable {
  let status: String
  let isError: Bool
  let descriptionKey: String
  
  enum CodingKeys: String, CodingKey{
    case status
    case isError
    case descriptionKey = "description"
  }
}

struct ResponseSignUpSuccess: Codable {
  let status: String
  let isError : Bool
  let data: Success
}

struct Success: Codable {
  let id: Int
  let fullName, username, email: String
  let createdAt, updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case fullName = "full_name"
    case username, email
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}
