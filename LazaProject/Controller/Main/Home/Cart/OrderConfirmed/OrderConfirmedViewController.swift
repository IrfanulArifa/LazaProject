//
//  OrderConfirmedViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 08/08/23.
//

import UIKit

protocol backToHome: AnyObject {
  func backToHome()
}

class OrderConfirmedViewController: UIViewController {
  
  @IBOutlet weak var orderConfirmed: UILabel!{
    didSet {
      orderConfirmed.font = UIFont(name: "Poppins-SemiBold", size: 28)
    }
  }
  
  @IBOutlet weak var subTitle: UILabel!{
    didSet {
      subTitle.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var goToOrders: UIButton!{
    didSet {
      goToOrders.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var continueShopping: UIButton!{
    didSet {
      continueShopping.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  weak var delegate: backToHome?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
  }
  
  @IBAction func goToOrdersClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func continueShopping(_ sender: Any) {
    delegate?.backToHome()
    self.navigationController?.popViewController(animated: true)
  }
}
