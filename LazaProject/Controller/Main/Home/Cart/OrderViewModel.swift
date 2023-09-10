//
//  OrderViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 10/09/23.
//

import Foundation

class OrderViewModel {
  
  var goToConfirm: (()-> Void)?
  func order(token: String,
             products: [ProductCheckoutData],
             addressId: Int,
             bank: String) {
    
    let encoder = JSONEncoder()
    let baseURL = Endpoint.APIAddress()+Endpoint.Path.orderBank.rawValue
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
    do {
      let checkout = Checkout(products: products, addressId: addressId, bank: bank)
      let jsonData = try encoder.encode(checkout)
      request.httpBody = jsonData
    } catch {
      print("Error Encoding Cart to JSON", error)
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { [self] data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      guard let data = data else { return }
      
      if httpResponse.statusCode != 201 {
        print("Error Status Code : \(httpResponse.statusCode) ")
      } else {
        goToConfirm?()
      }
    }
    task.resume()
  }
}
