//
//  SignUpViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 15/08/23.
//

import Foundation

class SignUpViewModel {
  func register(fullname: String,
                username:String,
                email: String,
                password: String,
                completion: @escaping ((ResponseSignUpSuccess?) -> Void),
                onError: @escaping (String) -> Void) {
    
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/register")!
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let parameters: [String: Any] = [
      "full_name":fullname,
      "username":username,
      "email":email,
      "password":password
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
      if let error = error {
        completion(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
//        onError("Respons server tidak valid")
        return
      }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return
      }
      
      print(httpResponse.statusCode)
      if httpResponse.statusCode != 201 {
        guard let failedModel = try? decoder.decode(ResponseSignUpFailed.self, from: data) else {
          onError("Register failed - Failed to decode")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      
      do {
        // Decode JSON response if needed
        //          let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        let result = try decoder.decode(ResponseSignUpSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error decoding JSON response: \(error)")
      }
      // Handle data response
    }
    
    // Mulai task
    task.resume()
  }
}
