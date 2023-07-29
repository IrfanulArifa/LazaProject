//
//  UserViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 29/07/23.
//

import UIKit

class UserViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarItemImage() // Calling Function
  }
  
  // MARK: Setup BarItem when Clicked Change into Text
  private func setupTabBarItemImage() {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = "User"
    label.font = UIFont(name: "Inter-Medium", size: 11)
    label.textColor = UIColor(named: "PurpleButton")
    label.sizeToFit()
    
    tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
    tabBarItem.selectedImage = UIImage(view: label)
  }
}
