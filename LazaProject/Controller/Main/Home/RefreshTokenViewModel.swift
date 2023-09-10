//
//  RefreshTokenViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/09/23.
//

import Foundation
import JWTDecode

class RefreshTokenViewModel {
  
  func refreshTokenIfNeeded(refresh_token: String) {
    let decoder = JSONDecoder()
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.refresh.rawValue
    
    let url = URL(string: baseUrl)!
    
    var request = URLRequest(url: url)
    
    request.setValue("Bearer \(refresh_token)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthRefresh.rawValue)
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else { return }
      
      if httpResponse.statusCode != 200 {
        print("Error Status Code Refresh Token: \(httpResponse.statusCode)")
      }
      
      do {
        let result = try decoder.decode(LoginSuccess.self, from: data)
        UserDefaults.standard.setValue(result.data.access_token, forKey: "access_token")
      } catch {
        print("Error Decode Data Refresh Token, \(error)")
      }
    }
    task.resume()
  }
  
  func refreshToken() {
    do {
      UserDefaults.standard.synchronize()
      let token = UserDefaults.standard.string(forKey: "access_token")
      let refresh_token = UserDefaults.standard.string(forKey: "refresh_token")
      let jwt = try decode(jwt: token!)
      if jwt.expired {
        refreshTokenIfNeeded(refresh_token: refresh_token!)
      }
    } catch {
      print("Error Refresh Token")
    }
  }
}
