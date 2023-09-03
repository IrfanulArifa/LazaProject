//
//  AddNewCardViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 08/08/23.
//

import UIKit
import CreditCardForm
import Stripe

class AddNewCardViewController: UIViewController, STPPaymentCardTextFieldDelegate {
  
  @IBOutlet weak var addNewCard: UILabel!{
    didSet {
      addNewCard.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var creditCardView: CreditCardFormView!
  
  @IBOutlet weak var cardPaymentTxtField: STPPaymentCardTextField!
  
  @IBOutlet weak var saveCardBtn: UIButton!{
    didSet {
      saveCardBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cardPaymentTxtField.delegate = self
//    removeCVC()
    print()
    
  }
  
  func removeCVC() {
    if let fieldViews = cardPaymentTxtField.subviews.first {
      for subView in fieldViews.subviews where subView.tag == 0 {
        (subView as? UITextField)?.text = "123"
        subView.removeFromSuperview()
      }
    }
  }
  
  func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
  creditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: UInt(textField.expirationYear), expirationMonth: UInt(textField.expirationMonth), cvc: textField.cvc)
  }

  func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
  creditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: UInt(textField.expirationYear))
  }

  func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
  creditCardView.paymentCardTextFieldDidBeginEditingCVC()
  }

  func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
  creditCardView.paymentCardTextFieldDidEndEditingCVC()
  }
}
