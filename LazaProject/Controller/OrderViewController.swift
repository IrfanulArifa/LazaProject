//
//  OrderViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItemImage()
    }
    

  private func setupTabBarItemImage() {
      let label = UILabel()
      label.numberOfLines = 1
      label.textAlignment = .center
      label.text = "Order"
      label.font = UIFont(name: "Inter-Medium", size: 11)
      label.sizeToFit()
      
      tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
      tabBarItem.selectedImage = UIImage(view: label)
  }

}
