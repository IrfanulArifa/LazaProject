//
//  LoginViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 15/08/23.
//

import Foundation
import UIKit
import JWTDecode

class LoginViewModel{
  
  var AccessToken: LoginValid?
  var userData: DataClass?
  var jumpClick: (() -> Void)?
  
  func login(username: String,
             password: String,
             completion: @escaping ((LoginValid?) -> Void),
             onError: @escaping ((String) -> Void)){
    
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/login")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let parameters: [String: Any] = [
      "username":username,
      "password":password
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      print("Error saat membuat data JSON: \(error)")
      return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(LoginFailed.self, from: data) else {
          onError("Login failed - Failed to decode")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      
      do {
        let result = try decoder.decode(LoginSuccess.self, from: data)
        completion(result.data)
        let jwt = try decode(jwt: result.data.access_token)
      } catch {
        print("Error decoding JSON response: \(error)")
      }
    }
    task.resume()
  }
  
  func getProfileData(token: String) {
    let component = URLComponents(string: "https://lazaapp.shop/user/profile")!
    var request = URLRequest(url: component.url!)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return
      }
      
      if httpResponse.statusCode == 200 {
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode(User.self, from: data)
          self.jumpClick?()
          ViewModel().saveProfil(token:token ,fullname: result.data.fullName, username: result.data.username, email: result.data.email)
        } catch {
          print("Error decoding JSON response: \(error)")
        }
  
      }
    }
    task.resume()
  }  
}
