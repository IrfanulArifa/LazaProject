//
//  AddressViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 29/08/23.
//

import Foundation

class AddressViewModel {
  let userToken = UserDefaults.standard.string(forKey: "access_token")
  var allAddressData = [AllAddressData]()
  var reloadData: (()->Void)?
  var jumpClick: (()-> Void)?
  
  func addNewAddress(country: String,
                     city: String,
                     receiverName: String,
                     number: String,
                     isPrimary: Bool,
                     completion: @escaping (NewAddressData?)->Void,
                     onError: @escaping (String)->Void){
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/address")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: "X-Auth-Token")
    
    let parameters: [String: Any] = [
      "country":country,
      "city":city,
      "receiver_name":receiverName,
      "phone_number":number,
      "is_primary": isPrimary
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      print("Error saat membuat data JSON: \(error)")
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        onError("Invalid Response")
        return
      }
      
      guard let data = data else {
        onError("Data Kosong")
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
        let result = try decoder.decode(AddNewAddress.self, from: data)
        completion(result.data)
      } catch {
        print("error, \(error)")
      }
    }
    task.resume()
  }
  
  func getAllAddress(){
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/address")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: "X-Auth-Token")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Error, \(error!)")
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      
      if httpResponse.statusCode != 200 {
        print("HTTP Response", httpResponse)
      }
      
      guard let data = data else{
        print("Tidak ada data yang diterima")
        return
      }
      
      do {
        let result = try decoder.decode(AllAddress.self, from: data)
        self.allAddressData = result.data
        self.reloadData?()
      } catch {
        print(error)
      }
    }
    task.resume()
  }
  
  func updateAddress(idAddress: Int, country: String, city: String, receiverName: String, number: String, isPrimary: Bool, completion: @escaping (UpdateUserAddressData?)-> Void, onError: @escaping (String) -> Void ) {
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/address/\(idAddress)")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: "X-Auth-Token")
    
    let parameters: [String: Any] = [
      "country":country,
      "city":city,
      "receiver_name":receiverName,
      "phone_number":number,
      "is_primary": isPrimary
    ]
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      print("Error saat membuat data JSON: \(error)")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        onError("Invalid Response")
        return
      }
      
      guard let data = data else {
        onError("Data Kosong")
        return
      }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(ResponseSignUpFailed.self, from: data) else {
          onError("Failed to Decode")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      
      do {
        let result = try decoder.decode(UpdateUserAddress.self, from: data)
        completion(result.data)
      } catch {
        print("Error Decode JSON Success: \(error)")
      }
    }
    task.resume()
  }
  
  func deleteAddress(idAddress: Int, completion: @escaping (DeleteSuccess?) -> Void, onError: @escaping (String) -> Void ){
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/address/\(idAddress)")!
    var request = URLRequest(url: url)
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: "X-Auth-Token")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        onError("Invalid Response")
        return
      }
      
      guard let data = data else {
        onError("Data Kosong")
        return
      }
      
      if httpResponse.statusCode != 200 {
        guard let failedModel = try? decoder.decode(DeleteFailed.self, from: data) else {
          onError("Failed to Decode")
          return
        }
        onError(failedModel.description)
        return
      }
      
      do {
        let result = try decoder.decode(DeleteSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error Decode JSON Success: \(error)")
      }
    }
    task.resume()
  }
}
