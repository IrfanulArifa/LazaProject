//
//  UserModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 29/07/23.
//

import Foundation

struct UserModel {
  // MARK: Declare User Model
  static let stateLoginKey = "state"
  static let accessTokenKey = "access_token"
  static let fullnameKey = "fullname"
  static let usernameKey = "username"
  static let emailKey = "email"
  static let imageKey = "image"
  static let newUserKey = "new_user"
  
  // Encaptulation ??
  static var stateLogin: Bool {
    get { return UserDefaults.standard.bool(forKey: stateLoginKey) }
    set { UserDefaults.standard.set(newValue, forKey: stateLoginKey) }
  }
  
  static var access_token: String {
    get { return UserDefaults.standard.string(forKey: accessTokenKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: accessTokenKey) }
  }
  
  static var fullname: String {
    get { return UserDefaults.standard.string(forKey: fullnameKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: fullnameKey) }
  }
  
  static var username: String {
    get { return UserDefaults.standard.string(forKey: usernameKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: usernameKey) }
  }
  
  static var email: String {
    get { return UserDefaults.standard.string(forKey: emailKey) ?? ""}
    set { UserDefaults.standard.set(newValue, forKey: emailKey) }
  }
  
  static var image: String {
    get { return UserDefaults.standard.string(forKey: imageKey) ?? ""}
    set { UserDefaults.standard.set(newValue, forKey: imageKey)}
  }
  
  static var new_user: Bool {
    get { return UserDefaults.standard.bool(forKey: newUserKey)}
    set { UserDefaults.standard.set(newValue, forKey: newUserKey)}
  }
  
  // MARK: For Deleting All User
  static func deleteAll() -> Bool {
    if let domain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: domain)
      synchronize()
      return true
    } else { return false }
  }
  
  // MARK : Synchronize
  static func synchronize() {
    UserDefaults.standard.synchronize()
  }
}

struct User: Codable {
    let status: String
    let isError: Bool
    let data: DataClassUser
}

// MARK: - DataClass
struct DataClassUser: Codable {
    let id: Int
    let fullName, username, email: String
    let imageURL: String?
  
    let isVerified: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case username, email
        case isVerified = "is_verified"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case imageURL = "image_url"
    }
}

struct UpdateUserSuccess: Codable {
    let status: String
    let isError: Bool
    let data: UserSuccess
}

// MARK: - DataClass
struct UserSuccess: Codable {
    let id: Int
    let fullName, username, email: String
    let imageURL: String?
    let isVerified: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case username, email
        case imageURL = "image_url"
        case isVerified = "is_verified"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

