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
  var wishlistData: WishlistModel?
  var reloadDetail: (()->Void)?
  var reloadReview: (()->Void)?
  var reloadWishlist: (()->Void)?
  var reLogin: (()->Void)?
  
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
  
  func getWishlist(token:String) async throws -> WishlistModel {
    let component = URLComponents(string: "https://lazaapp.shop/wishlists")!
    var request = URLRequest(url:component.url!)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    let (data, responses) = try await URLSession.shared.data(for: request)
    guard (responses as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error Can't Fetching Data")
    }
    let decoder = JSONDecoder()
    let result = try decoder.decode(WishlistModel.self, from: data)
    return result
  }
  
  func loadDetail(_ index: Int) {
    Task { await getDetailData(index) }
  }
  
  func isInWishlist(token: String){
    Task { await checkWishlistData(token) }
  }
  
  func loadWhislist(token: String) {
//    Task { await }
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
      fatalError("Token is Invalid")
    }
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(ReviewData.self, from: data)
    return result
  }

  func checkWishlistData(_ token: String) async {
    do {
      wishlistData = try await getWishlist(token: token)
      reloadWishlist?()
    } catch {
      print("Gamasuk ke Review \(error)")
    }
  }
  
  func getReviewData(_ index: Int) async {
    do {
      reviewData = try await getReviewById(productId: index)
      reloadReview?()
    } catch {
      print("Gamasuk ke Review \(error)")
    }
  }
  
  func putWishlist(productId: String,
                   token: String,
                   completion: @escaping ((WishlistSuccess?)->Void),
                   onError: @escaping (String)->Void) {
    let decoder = JSONDecoder()
    
    let url = URL(string: "https://lazaapp.shop/wishlists?ProductId=\(productId)")!
  
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "X-Auth-Token")
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
      if error != nil {
        completion(nil)
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
        guard let failedModel = try? decoder.decode(ResponseSignUpFailed.self, from: data) else {
          onError("Put Wishlist Failed - Failed to Decode")
          return
        }
        onError(failedModel.descriptionKey)
        return
      }
      do {
        let result = try decoder.decode(WishlistSuccess.self, from: data)
        completion(result)
      } catch {
        print("Error decoding JSON response: \(error)")
      }
    }
    task.resume()
  }
}


