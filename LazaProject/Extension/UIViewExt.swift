//
//  UIViewExt.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 09/08/23.
//

import UIKit

extension UIView {
  // MARK: set cornerRadius into View Setting
  @IBInspectable var cornerRadius: CGFloat {
    get { return self.cornerRadius }
    set { self.layer.cornerRadius = newValue}
  }
}

extension UIImage {
  // This method creates an image of a view
  convenience init?(view: UIView) {
    
    // Based on https://stackoverflow.com/a/41288197/1118398
    let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
    let image = renderer.image { rendererContext in
      view.layer.render(in: rendererContext.cgContext)
    }
    
    if let cgImage = image.cgImage {
      self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
    } else {
      return nil
    }
  }
}

extension UIViewController {
  func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
      completion?()
    })
    present(alert, animated: true, completion: nil)
  }
  
  func showValidation(title: String, message: String, yes: (()-> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
      yes?()
    })
    alert.addAction(UIAlertAction(title: "No", style: .destructive))
    present(alert, animated: true, completion: nil)
  }
}
