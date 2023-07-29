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
  static let firstnameKey = "firstname"
  static let lastnameKey = "lastname"
  static let phoneKey = "phonenumber"
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
  
  static var firstname: String {
    get { return UserDefaults.standard.string(forKey: firstnameKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: firstnameKey) }
  }
  
  static var lastname: String {
    get { return UserDefaults.standard.string(forKey: lastnameKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: lastnameKey) }
  }
  
  static var phonenumber: String {
    get { return UserDefaults.standard.string(forKey: phoneKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: phoneKey)}
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
