//
//  VerificationCodeViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 20/08/23.
//

import Foundation

class VerificationCodeViewModel {
  
  func verificationToken(email: String,
                         otp: String,
                         completion: @escaping ((VerificationCodeSuccess?) -> Void),
                         onError: @escaping (String) -> Void){
    let decoder = JSONDecoder()
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.verification.rawValue
    
    let url = URL(string: baseUrl)!
    var request = URLRequest(url:url)
    
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let parameters: [String: Any] = [
      "email":email,
      "code":otp
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
      
      if httpResponse.statusCode != 202 {
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          onError("Verification Failed - Failed to Decode")
          return
        }
        onError(failedModel.description)
        return
      }
      
      do {
        let result = try decoder.decode(VerificationCodeSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error Decoding JSON response: \(error)")
      }
    }
    task.resume()
  }
}
