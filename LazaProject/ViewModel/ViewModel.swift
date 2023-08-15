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
  
  // MARK: Get User Data from API
  func getUser() async throws -> UserData {
    let component = URLComponents(string: "https://fakestoreapi.com/users")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(UserData.self, from: data)
    return result
  }
  
  // MARK: Get All Size Data From API
  func getSize() async throws -> [Sizes] {
    let component = URLComponents(string: "https://lazaapp.shop/size")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(Size.self, from: data)
    return result.data
  }
  
  // MARK: Load All Data that Get From API
  func loadData(){
    Task {
      //      await getCategoriesData()
      await getProductData()
      await getBrandData()
    }
  }
  
  // MARK: Load User Data
  func loadDataUser(){
    Task {
      await getUserData()
    }
  }
  
  func loadSize(){
    Task {
      await getSizeData()
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
  func getUserData() async {
    do {
      userData = try await getUser()
      reloadUser?()
    } catch {
      print("Error")
    }
  }
  
  func getBrandData() async {
    do {
      brand = try await getBrand()
      reloadCategory?()
    } catch {
      print("Error")
    }
  }
  
  func getSizeData() async {
    do {
      size = try await getSize()
      reloadSize?()
    } catch {
      print("Error")
    }
  }
  
  func saveProfil(name: String, email: String, password: String) {
    UserModel.stateLogin = true
    UserModel.name = name
    UserModel.email = email
    UserModel.password = password
  }
}
