//
//  NewPasswordViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 20/08/23.
//

import Foundation

class NewPasswordViewModel {
  func resetPassword(email: String,
                     otpData: String,
                     new_password: String,
                     re_password: String,
                     completion: @escaping (ResetPasswordSucces?) -> Void,
                     onError: @escaping (String) -> Void) {
    let decoder = JSONDecoder()
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.resetPassword.rawValue
    
    var component = URLComponents(string: baseUrl)!
    
    component.queryItems = [
      URLQueryItem(name: "email", value: email),
      URLQueryItem(name: "code", value: otpData)
    ]
    
    var request = URLRequest(url: component.url!)
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let parameters: [String: Any] = [
      "new_password": new_password,
      "re_password": re_password
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      print("Error creating JSON data: \(error)")
      onError("Failed to create JSON data")
      return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if let error = error {
        onError(error.localizedDescription)
        return
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
        let result = try decoder.decode(ResetPasswordSucces.self, from: data)
        completion(result)
      } catch {
        onError("Failed to decode success response")
      }
    }
    // Start the network request
    task.resume()
  }
}
