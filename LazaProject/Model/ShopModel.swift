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
  let deletedAt: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case logoURL = "logo_url"
    case deletedAt = "deleted_at"
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

// MARK: Add New Data

struct AddNewAddress: Codable {
  let status: String
  let isError: Bool
  let data: NewAddressData
}

// MARK: - DataClass
struct NewAddressData: Codable {
  let id: Int
  let country, city, receiverName, phoneNumber: String
  let isPrimary: Bool?
  let userID: Int
  let user: UserAddress
  
  enum CodingKeys: String, CodingKey {
    case id, country, city
    case receiverName = "receiver_name"
    case phoneNumber = "phone_number"
    case isPrimary = "is_primary"
    case userID = "user_id"
    case user
  }
}

// MARK: - User
struct UserAddress: Codable {
  let createdAt, updatedAt: String
  let deletedAt: String?
  
  enum CodingKeys: String, CodingKey {
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case deletedAt = "deleted_at"
  }
}

struct AllAddress: Codable {
  let status: String
  let isError: Bool
  let data: [AllAddressData]
}

// MARK: - Datum
struct AllAddressData: Codable {
  let id: Int
  let country, city, receiverName, phoneNumber: String
  let userID: Int
  let user: UserAllAddress
  let isPrimary: Bool?
  
  enum CodingKeys: String, CodingKey {
    case id, country, city
    case receiverName = "receiver_name"
    case phoneNumber = "phone_number"
    case userID = "user_id"
    case user
    case isPrimary = "is_primary"
  }
}

// MARK: - User
struct UserAllAddress: Codable {
  let id: Int
  let username: String
  let email: String
  let fullName: String
  let createdAt, updatedAt: String
  let deletedAt: String?
  
  enum CodingKeys: String, CodingKey {
    case id, username, email
    case fullName = "full_name"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case deletedAt = "deleted_at"
  }
}

struct UpdateUserAddress: Codable {
  let status: String
  let isError: Bool
  let data: UpdateUserAddressData
}

// MARK: - DataClass
struct UpdateUserAddressData: Codable {
  let id: Int
  let country, city, receiverName, phoneNumber: String
  let isPrimary: Bool?
  let userID: Int
  let user: UserAddress
  
  enum CodingKeys: String, CodingKey {
    case id, country, city
    case receiverName = "receiver_name"
    case phoneNumber = "phone_number"
    case isPrimary = "is_primary"
    case userID = "user_id"
    case user
  }
}

struct DeleteSuccess: Codable {
  let status: String
  let isError: Bool
  let data: String
}

struct DeleteFailed: Codable {
  let status: String
  let isError: Bool
  let description: String
}

struct CartSuccess: Codable {
    let status: String
    let isError: Bool
    let data: DataCart
}

struct DataCart: Codable {
    var products: [Cart]?
    let orderInfo: OrderInfo

    enum CodingKeys: String, CodingKey {
        case products
        case orderInfo = "order_info"
    }
}

// MARK: - OrderInfo
struct OrderInfo: Codable {
    let subTotal, shippingCost, total: Int

    enum CodingKeys: String, CodingKey {
        case subTotal = "sub_total"
        case shippingCost = "shipping_cost"
        case total
    }
}

// MARK: - Product
struct Cart: Codable {
    let id: Int
    let productName: String
    let imageURL: String
    let price: Int
    let brandName: String
    let quantity: Int
    let size: String

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case imageURL = "image_url"
        case price
        case brandName = "brand_name"
        case quantity, size
    }
}

struct ReduceCart: Codable {
    let status: String
    let isError: Bool
    let data: ReduceCartData
}

// MARK: - DataClass
struct ReduceCartData: Codable {
    let userID, productID, sizeID, quantity: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case productID = "product_id"
        case sizeID = "size_id"
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct insertCart: Codable {
    let status: String
    let isError: Bool
    let data: insertCartData
}

// MARK: - DataClass
struct insertCartData: Codable {
    let userID, productID, sizeID, quantity: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case productID = "product_id"
        case sizeID = "size_id"
        case quantity
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct NewPassword: Codable {
    let status: String
    let isError: Bool
    let data: NewPasswordData
}

// MARK: - DataClass
struct NewPasswordData: Codable {
    let message: String
}

struct APIError: Codable {
    let status: String
    let isError: Bool
    let description: String
}
