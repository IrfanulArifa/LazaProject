//
//  PaymentCollectionViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 08/08/23.
//

import UIKit
import CreditCardForm

class PaymentCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var paymentCardView: CreditCardFormView!{
    didSet {
      
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func configure(name: String, number: String, expYear: UInt, expMonth: UInt, cvc: String) {
    paymentCardView.cardHolderString = name
    paymentCardView.paymentCardTextFieldDidChange(cardNumber: number, expirationYear: expYear, expirationMonth: expMonth, cvc: cvc)
  }
  
}
