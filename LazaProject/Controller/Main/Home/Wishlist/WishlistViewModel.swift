//
//  WishlistViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 22/08/23.
//

import Foundation

class WishlistViewModel {
  
  var wishlistData: WishlistModel?
  var reloadWishlist: (()->Void)?
  let refreshToken = RefreshTokenViewModel()
  
  func getWishlist(token: String) {
    let decoder = JSONDecoder()
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.wishlist.rawValue
    
    let url = URL(string: baseUrl)!
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else {
        print("Tidak ada data yang diterima"); return
      }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          print("Failed to Decode JSON"); return
        }
        print("Error, \(failedModel)")
      }
      
      do {
        let result = try decoder.decode(WishlistModel.self, from: data)
        self.wishlistData = result
        self.reloadWishlist?()
      } catch {
        print("Error decoding JSON response: \(error)")
      }
    }
    task.resume()
  }
}
