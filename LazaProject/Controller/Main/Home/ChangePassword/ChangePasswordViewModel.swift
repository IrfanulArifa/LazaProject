//
//  ChangePasswordViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 04/09/23.
//

import Foundation

class ChangePasswordViewModel {
  func changePassword(token: String,
                      oldPassword: String,
                      newPassword: String,
                      confirmPassword: String,
                      completion: @escaping ((NewPasswordData?)->Void),
                      onError: @escaping (String)->Void) {
    
    let decoder = JSONDecoder()
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.changePassword.rawValue
    
    let url = URL(string: baseUrl)!
    
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.PUT.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
    let parameters: [String: Any] = [
      "old_password":oldPassword,
      "new_password":newPassword,
      "re_password":confirmPassword
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      onError("Failed to Create JSON Data")
      return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        onError("Invalid response")
        return
      }
      
      guard let data = data else {
        onError("No data received")
        return
      }
      
      if httpResponse.statusCode != 200 {
        do {
          let failedModel = try decoder.decode(APIError.self, from: data)
          onError(failedModel.description)
        } catch {
          onError("Failed to decode error response")
        }
        return
      }
      
      do {
        let result = try decoder.decode(NewPassword.self, from: data)
        completion(result.data)
      } catch {
        onError("Failed to decode success response")
      }
    }
    task.resume()
  }
}
