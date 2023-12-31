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
    
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.address.rawValue
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.POST.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
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
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          onError("Failed to Decode")
          return
        }
        onError(failedModel.description)
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
    
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.address.rawValue
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.GET.rawValue
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
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
        self.allAddressData = self.allAddressData.reversed()
        self.reloadData?()
      } catch {
        print(error)
      }
    }
    task.resume()
  }
  
  func updateAddress(idAddress: Int, country: String, city: String, receiverName: String, number: String, isPrimary: Bool, completion: @escaping (UpdateUserAddressData?)-> Void, onError: @escaping (String) -> Void ) {
    let decoder = JSONDecoder()
    
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.addressint.rawValue + "\(idAddress)"
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.PUT.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
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
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          onError("Failed to Decode")
          return
        }
        onError(failedModel.description)
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
    
    let baseURL = Endpoint.APIAddress() + Endpoint.Path.addressint.rawValue + "\(idAddress)"
    
    let url = URL(string: baseURL)!
    var request = URLRequest(url: url)
    request.httpMethod = Endpoint.HttpMethod.DELETE.rawValue
    request.setValue("Bearer \(userToken!)", forHTTPHeaderField: Endpoint.HTTPHeader.XAuthToken.rawValue)
    
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
        guard let failedModel = try? decoder.decode(APIError.self, from: data) else {
          onError("Failed to Decode")
          return
        }
        onError(failedModel.description)
        return
      }
      
      do {
        let jsonSer = try JSONSerialization.jsonObject(with: data)
        print(jsonSer)
        let result = try decoder.decode(DeleteSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error Decode JSON Success: \(error)")
      }
    }
    task.resume()
  }
}
