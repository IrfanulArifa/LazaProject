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
  static let nameKey = "name"
  static let emailKey = "email"
  static let passwordKey = "password"
  
  // Encaptulation ??
  static var stateLogin: Bool {
    get { return UserDefaults.standard.bool(forKey: stateLoginKey) }
    set { UserDefaults.standard.set(newValue, forKey: stateLoginKey) }
  }
  
  static var name: String {
    get { return UserDefaults.standard.string(forKey: nameKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: nameKey) }
  }
  
  static var email: String {
    get { return UserDefaults.standard.string(forKey: emailKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: emailKey) }
  }
  
  static var password: String {
    get { return UserDefaults.standard.string(forKey: passwordKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: passwordKey)}
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
