//
//  PaymentCollectionViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 08/08/23.
//

import UIKit
import CreditCardForm

class PaymentCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var paymentCardView: CreditCardFormView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func configure(name: String, number: String, expYear: String, expMonth: String, cvc: String) {
    paymentCardView.cardHolderString = name
    paymentCardView.paymentCardTextFieldDidChange(cardNumber: number, expirationYear: UInt(expYear), expirationMonth: UInt(expMonth), cvc: cvc)
  }
  
}
