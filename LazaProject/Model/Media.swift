//
//  Media.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 23/08/23.
//

import UIKit

typealias Parameters = [String: String]

struct Media {
  let key: String
  let filename: String
  let data: Data
  let mimeType: String
  
  init?(withImage image: UIImage, forKey key: String) {
    self.key = key
    self.mimeType = "image/jpeg"
    self.filename = "agnesimage.jpg"
    
    // Resize image
    let size = CGSize(width: 300, height: 300)
    let renderer = UIGraphicsImageRenderer(size: size)
    let resizedImage = renderer.image { context in
      image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
    guard let data = resizedImage.jpegData(compressionQuality: 0.7) else { return nil }
    self.data = data
  }
  
  func resize(image: UIImage, size: CGSize) -> UIImage{
    
    let renderer = UIGraphicsImageRenderer(size: size)
    let resizedImage = renderer.image { context in
      image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
    
    return resizedImage
  }
}
