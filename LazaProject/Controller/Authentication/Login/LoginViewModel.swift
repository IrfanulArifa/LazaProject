//
//  LoginViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 15/08/23.
//

import Foundation
import UIKit

class LoginViewModel{
  
  var AccessToken: LoginValid?
  var userData: DataClass?
  var jumpClick: (() -> Void)?
  var invalidToken: (()-> Void)?
  var jumpToSetProfile: (()-> Void)?
  
  func login(username: String,
             password: String,
             completion: @escaping ((LoginValid?) -> Void),
             onError: @escaping ((String) -> Void)){
    
    let decoder = JSONDecoder()
    
    let baseURL = Endpoint.APIAddress()+Endpoint.Path.login.rawValue
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let parameters: [String: Any] = [
      "username":username,
      "password":password
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      print("Error saat membuat data JSON Login: \(error)")
      return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          onError("Login failed - Failed to decode")
          return
        }
        onError(failedModel.description)
        return
      }
      
      do {
        let result = try decoder.decode(LoginSuccess.self, from: data)
        completion(result.data)
      } catch {
        print("Error decoding JSON response in Login: \(error)")
      }
    }
    task.resume()
  }
  
  func getProfileData(token: String, refreshToken: String) {
    
    let baseURL = Endpoint.APIAddress()+Endpoint.Path.profil.rawValue
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "\(Endpoint.HTTPHeader.XAuthToken.rawValue)")
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
          ViewModel().saveProfil(token:token, refreshToken: refreshToken ,fullname: result.data.fullName, username: result.data.username, email: result.data.email, image: result.data.imageURL ?? "", userId: result.data.id)
          if result.data.imageURL != nil {
            self.jumpClick?()
          } else {
            self.jumpToSetProfile?()
          }
        } catch {
          print("Error decoding JSON response: \(error)")
        }
  
      } else if httpResponse.statusCode != 200 {
        self.invalidToken?()
      }
    }
    task.resume()
  }  
}
