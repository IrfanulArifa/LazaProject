//
//  ChoosePaymentViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 09/08/23.
//

import UIKit

protocol backToCartDelegate: AnyObject {
  func backToCart()
}

class ChoosePaymentViewController: UIViewController {
  
  var choosedPayment = ""
  weak var delegate: backToCartDelegate?
  @IBOutlet weak var choosePayment: UILabel!{
    didSet {
      choosePayment.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  @IBOutlet weak var gopayCheck: UIButton!{
    didSet {
      gopayCheck.setImage(UIImage(systemName: "square"), for: .normal)
    }
  }
  
  @IBOutlet weak var creditCheck: UIButton!{
    didSet {
      creditCheck.setImage(UIImage(systemName: "square"), for: .normal)
    }
  }
  
  @IBOutlet weak var gopay: UILabel!{
    didSet {
      gopay.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var creditCard: UILabel!{
    didSet { creditCard.font = UIFont(name: "Poppins-Regular", size: 15) }
  }
  
  @IBOutlet weak var goToPayment: UIButton!{
    didSet { goToPayment.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    delegate?.backToCart()
  }
  
  @IBAction func gopayButtonCheck(_ sender: Any) {
    if gopayCheck.currentImage == UIImage(systemName: "square") {
      choosedPayment = "Gopay"
      gopayCheck.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
      creditCheck.setImage(UIImage(systemName: "square"), for: .normal)
    } else if gopayCheck.currentImage == UIImage(systemName: "checkmark.square") {
      choosedPayment = ""
      gopayCheck.setImage(UIImage(systemName: "square"), for: .normal)
    }
  }
  
  @IBAction func creditCardCheck(_ sender: UIButton) {
    if creditCheck.currentImage == UIImage(systemName: "square") {
      choosedPayment = "CreditCard"
      creditCheck.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
      gopayCheck.setImage(UIImage(systemName: "square"), for: .normal)
    } else if creditCheck.currentImage == UIImage(systemName: "checkmark.square") {
      choosedPayment = ""
      creditCheck.setImage(UIImage(systemName: "square"), for: .normal)
    }
  }
  
  @IBAction func goToPayment(_ sender: UIButton) {
    if choosedPayment == "Gopay" {
      
    } else if choosedPayment == "CreditCard" {
      let storyboard = UIStoryboard(name: "PaymentViewController", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
}
