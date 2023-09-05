//
//  ViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import Foundation
import UIKit

class ViewModel {
  var product: [Datum] = []
  var brand: [Description] = []
  var size: [Sizes] = []
  var userData = UserData()
  var response: [ResponseSignUpSuccess] = []
  var reloadCategory: (() -> Void)?
  var reloadProduct: (() -> Void)?
  var reloadUser: (()-> Void)?
  var reloadSize: (()-> Void)?
  
  // MARK: Get Product Data from API
  
  func getProduct() async throws -> [Datum] {
    let component = URLComponents(string: "https://lazaapp.shop/products")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(Welcome.self, from: data)
    return result.data
  }
  
  func getBrand() async throws -> [Description] {
    let component = URLComponents(string: "https://lazaapp.shop/brand")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(Brand.self, from: data)
    return result.description
  }
  
  // MARK: Get All Size Data From API
  func getAllSize(completion: @escaping (Size) -> Void){
    let decoder = JSONDecoder()
    let url = URL(string: "https://lazaapp.shop/size")!
    let request = URLRequest(url: url)
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Error : ",error as Any)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      
      guard let data = data else {
        print("Tidak ada data yang diterima")
        return
      }
      
      if httpResponse.statusCode != 200 {
        print("Error", httpResponse.statusCode)
      }
      
      do {
        let result = try decoder.decode(Size.self, from: data)
        completion(result)
      } catch {
        print("Gagal melakukan Decode JSON : ", error)
      }
    }
    task.resume()
  }
  
  // MARK: Load All Data that Get From API
  func loadData(){
    Task {
      await getProductData()
      await getBrandData()
    }
  }
  
  // MARK: Get Product Data from API Async -> XCode say Must Set Async
  func getProductData() async {
    do {
      product = try await getProduct()
      reloadProduct?() // Closure For Reload Table
    } catch {
      print("Error")
    }
  }
  
  // MARK: Get User Data from API Async -> XCode say Must Set Async
  
  func getBrandData() async {
    do {
      brand = try await getBrand()
      reloadCategory?()
    } catch {
      print("Error")
    }
  }
  
  func updateProfil(token: String, fullname: String, username: String, email: String, image: String) {
    UserModel.stateLogin = true
    UserModel.access_token = token
    UserModel.fullname = fullname
    UserModel.username = username
    UserModel.email = email
    UserModel.image = image
  }
  
  func saveProfil(token: String, refreshToken: String, fullname: String, username: String, email: String, image: String){
    UserModel.stateLogin = true
    UserModel.access_token = token
    UserModel.refresh_token = refreshToken
    UserModel.fullname = fullname
    UserModel.username = username
    UserModel.email = email
    UserModel.image = image
  }
}
