//
//  SignUpViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 15/08/23.
//

import Foundation

class SignUpViewModel {
  
  var responseSignUp: ResponseSignUpSuccess?
  
  func register(fullname: String,
                username:String,
                email: String,
                password: String,
                completion: @escaping ((ResponseSignUpSuccess?) -> Void),
                onError: @escaping (String) -> Void) {
    
    let decoder = JSONDecoder()
    
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.register.rawValue
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url:url)
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
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
      print("Error saat membuat data JSON Sign Up: \(error)")
      completion(nil)
      return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return
      }
      
      if httpResponse.statusCode != 201 {
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          onError("Register failed - Failed to decode")
          return
        }
        onError(failedModel.description)
        return
      }
      
      do {
        let result = try decoder.decode(ResponseSignUpSuccess.self, from: data)
        self.responseSignUp = result
        completion(result)
      } catch {
        print("Error decoding JSON response Sign Up: \(error)")
      }
    }
    task.resume()
  }
}
