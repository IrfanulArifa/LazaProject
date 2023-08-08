//
//  BottomSheetViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

protocol MoveIntoDelegate: AnyObject {
  func moveIntoDeliveries()
  func moveIntoPayment()
}

class BottomSheetViewController: UIViewController {
  
  weak var delegate : MoveIntoDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  @IBAction func deliveryAddressClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.moveIntoDeliveries()
  }
  
  @IBAction func paymentMethodClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.moveIntoPayment()
  }
}
