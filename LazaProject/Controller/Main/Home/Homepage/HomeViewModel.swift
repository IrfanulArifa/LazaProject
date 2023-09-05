//
//  HomeViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import Foundation
import JWTDecode

class HomeViewModel {
  let loginModel = LoginViewModel()
  let viewModel = ViewModel()
  var productByName = [Datum]()
  var reloadTable: (()-> Void)?
  
  func getProductByName(name: String) async throws -> [Datum] {
    
    let baseUrl = Endpoint.APIAddress() + Endpoint.Path.product.rawValue
    
    var component = URLComponents(string: baseUrl)!
    
    component.queryItems = [
      URLQueryItem(name: "name", value: name)
    ]

    let request = URLRequest(url: component.url!)
    
    let session = URLSession.shared
    
    let (data, responses) = try await session.data(for: request)
    
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(Welcome.self, from: data)
    return result.data
  }
  
  func loadData(_ name: String){
    Task { await getProductData(name) }
  }
  
  func getProductData(_ name: String) async {
    do {
      productByName = try await getProductByName(name: name)
      reloadTable?()
    } catch {
      print("Gamasuk ke Data \(error)")
    }
  }
  
  
}
