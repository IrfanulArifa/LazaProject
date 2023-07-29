//
//  ViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import Foundation
import UIKit

class ViewModel {
  var welcome = Welcome()
  var welcomeElement = WelcomeProduct()
  var userData = UserData()
  var reloadCategory: (() -> Void)?
  var reloadProduct: (() -> Void)?
  
  // MARK: Get Categories Data from API
  func getCategories() async throws -> Welcome {
    let component = URLComponents(string: "https://fakestoreapi.com/products/categories")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(Welcome.self, from: data)
    return result
  }
  
  // MARK: Get Product Data from API
  func getProduct() async throws -> WelcomeProduct {
    let component = URLComponents(string: "https://fakestoreapi.com/products")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(WelcomeProduct.self, from: data)
    return result
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
  
  // MARK: Load All Data that Get From API
  func loadData(){
    Task {
      await getCategoriesData()
      await getProductData()
    }
  }
  
  // MARK: Load User Data
  func loadDataUser(){
    Task {
      await getUserData()
    }
  }
  
  // MARK: Get Categories Data from API Async -> XCode say Must Set Async
  func getCategoriesData() async {
    do {
      welcome = try await getCategories()
      //      print(welcome)
      reloadCategory?() // Closure For Reload Table
    } catch {
      print("Error")
    }
  }
  
  // MARK: Get Product Data from API Async -> XCode say Must Set Async
  func getProductData() async {
    do {
      welcomeElement = try await getProduct()
      reloadProduct?() // Closure For Reload Table
    } catch {
      print("Error")
    }
  }
  
  // MARK: Get User Data from API Async -> XCode say Must Set Async
  func getUserData() async {
    do {
      userData = try await getUser()
    } catch {
      print("Error")
    }
  }
  
  func saveProfil(name: String, email: String, firstname: String, lastname: String, phonenumber: String, password: String) {
    UserModel.stateLogin = true
    UserModel.name = name
    UserModel.email = email
    UserModel.firstname = firstname
    UserModel.lastname = lastname
    UserModel.phonenumber = phonenumber
    UserModel.password = password
  }
}
