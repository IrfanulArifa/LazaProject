//
//  RefreshTokenViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/09/23.
//

import Foundation

class RefreshTokenViewModel {
  
  var reloadData: (()-> Void)?
  
  func refreshTokenIfNeeded(refresh_token: String) {
    let decoder = JSONDecoder()
    let url = URL(string: "https://lazaapp.shop/auth/refresh")!
    var request = URLRequest(url: url)
    
    request.setValue("Bearer \(refresh_token)", forHTTPHeaderField: "X-Auth-Refresh")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else { return }
      
      if httpResponse.statusCode != 200 {
        print("Error Status Code: \(httpResponse.statusCode)")
      }
      
      do {
        let result = try decoder.decode(LoginSuccess.self, from: data)
        UserDefaults.standard.setValue(result.data.access_token, forKey: "access_token")
        self.reloadData?()
      } catch {
        print("Error Decode Data, \(error)")
      }
    }
    task.resume()
  }
}
