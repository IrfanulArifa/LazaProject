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

extension CGColor {
    static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> CGColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
    }
}
