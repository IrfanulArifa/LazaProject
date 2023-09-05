//
//  AddReviewViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 22/08/23.
//

import Foundation

class AddReviewViewModel {
  func addReview(productId: Int,
                 comment: String,
                 rating: Double,
                 token: String,
                 completion: @escaping ((ReviewSuccess?) -> Void),
                 onError: @escaping (String) -> Void) {
    
    let decoder = JSONDecoder()
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.detail.rawValue + "\(productId)" + Endpoint.Path.reviews.rawValue
    
    let url = URL(string: baseUrl)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
    let parameters: [String: Any] = [
      "comment": comment,
      "rating": rating
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
        let result = try decoder.decode(ReviewSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error decoding JSON response: \(error)")
      }
    }
    task.resume()
  }
}
