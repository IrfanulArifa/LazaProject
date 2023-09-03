//
//  OrderConfirmedViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 08/08/23.
//

import UIKit

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
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func goToOrdersClicked(_ sender: UIButton) {
    
  }
  
  @IBAction func continueShopping(_ sender: Any) {
  }
}
