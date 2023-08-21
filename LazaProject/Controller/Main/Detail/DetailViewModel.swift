//
//  DetailViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import Foundation

class DetailViewModel {
  
  var detailData: Detail?
  var reloadDetail: (()->Void)?
  
  func getDetailById(id: Int) async throws -> Detail {
    let component = URLComponents(string: "https://lazaapp.shop/products/\(id)")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(Detail.self, from: data)
    return result
  }
  
  func loadDetail(_ index: Int) {
    Task { await getDetailData(index) }
  }

  func getDetailData(_ index: Int) async {
    do {
      detailData = try await getDetailById(id: index)
    } catch {
      print("Gamasuk \(error)")
    }
  }
}


