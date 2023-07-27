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
  var reloadCategory: (() -> Void)?
  var reloadProduct: (() -> Void)?
//  var Detail : WelcomeElement!
  
  
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
  
  func loadCategories(){
    Task {
      await getCategoriesData()
      await getProductData()
    }
  }
  
  func getCategoriesData() async {
    do {
      welcome = try await getCategories()
      reloadCategory?()
    } catch {
      print("Error")
    }
  }
  
  func getProductData() async {
    do {
      welcomeElement = try await getProduct()
      reloadProduct?()
    } catch {
      print("Error")
    }
  }
}
