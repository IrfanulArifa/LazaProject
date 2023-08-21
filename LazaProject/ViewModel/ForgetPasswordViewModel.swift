//
//  ForgetPasswordViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 20/08/23.
//

import Foundation

class ForgetPasswordViewModel {
  func forgotPassword(email: String,
                      completion: @escaping ((ForgetPasswordSuccess?) -> Void),
                      onError: @escaping (String) -> Void) {
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/auth/forgotpassword")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let parameters: [String: Any] = [
      "email" : email
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      print("Error saat membuat data JSON: \(error)")
      completion(nil)
      return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      guard let httpResponse = response as? HTTPURLResponse else { return }
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return
      }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(ForgetPasswordFailed.self, from: data) else {
          onError("Register failed - Failed to get Data")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      do {
        let result = try decoder.decode(ForgetPasswordSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error decoding JSON response: \(error)")
      }
    }
    task.resume()
  }
}