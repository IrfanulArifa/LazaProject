//
//  SessionManager.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 16/08/23.
//

import Foundation

class SessionManager {
  static let shared = SessionManager()
  
  private(set) var userData: DataClass?
  
  func setCurrentUserData(data: DataClass) {
    userData = data
  }
}
