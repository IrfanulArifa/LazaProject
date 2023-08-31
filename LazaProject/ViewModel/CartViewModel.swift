//
//  CartViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 30/08/23.
//

import Foundation

class CartViewModel {
  var cartData: DataCart?
  var reloadData: (() -> Void)?
  var deleteData: (() -> Void)?
  
  func getAllCart(token: String){
    let decoder = JSONDecoder()
    let url = URL(string: "https://lazaapp.shop/carts")!
    var request = URLRequest(url: url)
    
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else { return }
      
      guard let data = data else { return }
      
      if httpResponse.statusCode != 200 {
        print("Error Status Code: \(httpResponse.statusCode)")
      }
      
      do {
        
        let dataResult = try JSONSerialization.jsonObject(with: data)
        print("Hasilnya ini: ", dataResult)
        let result = try decoder.decode(CartSuccess.self, from: data)
        self.cartData = result.data
        self.reloadData?()
      } catch {
        print("Error Decode Data, \(error)")
      }
    }
    task.resume()
  }
  
  func reduceCart(token: String, productID: Int, sizeID: Int, completion: @escaping (ReduceCartData?) -> Void, onError: @escaping(String) -> Void ){
    let decoder = JSONDecoder()
    let url = URL(string: "https://lazaapp.shop/carts?ProductId=\(productID)&SizeId=\(sizeID)")!
    var request = URLRequest(url: url)
    
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    request.httpMethod = "PUT"
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Error Mendapatkan JSON, \(String(describing: error))")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid Response")
        return
      }
      
      guard let data = data else {
        print("Data Kosong")
        return
      }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(ResponseSignUpFailed.self, from: data) else {
          onError("Register failed - Failed to Decode")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      do {
        let result = try decoder.decode(ReduceCart.self, from: data)
        completion(result.data)
      } catch {
        completion(nil)
      }
    }
    task.resume()
  }
  
  func deleteCart(token: String, productID: Int, sizeID: Int){
    let url = URL(string: "https://lazaapp.shop/carts?ProductId=\(productID)&SizeId=\(sizeID)")!
    var request = URLRequest(url: url)
    
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    request.httpMethod = "DELETE"
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid Response")
        return
      }
      
      guard data != nil else {
        print("Data Kosong")
        return
      }
      
      if httpResponse.statusCode != 200 {
        print("Error Status Code: \(httpResponse.statusCode)")
      }
    }
    task.resume()
  }
  
  func insertCartData(token: String, productID: Int, sizeID: Int, completion: @escaping (insertCartData?) -> Void, onError: @escaping(String) -> Void){
    let decoder = JSONDecoder()
    let url = URL(string: "https://lazaapp.shop/carts?ProductId=\(productID)&SizeId=\(sizeID)")!
    var request = URLRequest(url: url)
    
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    request.httpMethod = "POST"
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Data Tidak Masuk")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid Response")
        return
      }
      
      guard let data = data else {
        print("Data Kosong")
        return
      }
      
      if httpResponse.statusCode != 201 {
        guard let failedModel = try? decoder.decode(ResponseSignUpFailed.self, from: data) else {
          onError("Failed to Decode")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      
      do {
        let result = try decoder.decode(insertCart.self, from: data)
        completion(result.data)
      } catch {
        print(error)
      }
    }
    task.resume()
  }
}
