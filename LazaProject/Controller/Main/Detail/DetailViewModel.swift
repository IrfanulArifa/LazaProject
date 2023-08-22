//
//  DetailViewModel.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 21/08/23.
//

import Foundation

class DetailViewModel {
  
  var detailData: Detail?
  var reviewData: ReviewData?
  var reloadDetail: (()->Void)?
  var reloadReview: (()->Void)?
  
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
  
  func loadReview(_ index: Int) {
    Task { await getReviewData(index) }
  }

  func getDetailData(_ index: Int) async {
    do {
      detailData = try await getDetailById(id: index)
      reloadDetail?()
    } catch {
      print("Gamasuk \(error)")
    }
  }
  
  func getReviewById(productId: Int) async throws -> ReviewData {
    let component = URLComponents(string: "https://lazaapp.shop/products/\(productId)/reviews")!
    let request = URLRequest(url:component.url!)
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(ReviewData.self, from: data)
    return result
  }

  func getReviewData(_ index: Int) async {
    do {
      reviewData = try await getReviewById(productId: index)
      reloadReview?()
    } catch {
      print("Gamasuk ke Review \(error)")
    }
  }
}


