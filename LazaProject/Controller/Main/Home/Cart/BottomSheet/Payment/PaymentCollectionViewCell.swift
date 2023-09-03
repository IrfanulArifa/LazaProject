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

  func configure() {
    paymentCardView.cardHolderString = ""
    paymentCardView.paymentCardTextFieldDidChange(cardNumber: "`", expirationYear: UInt(25), expirationMonth: UInt(12), cvc: "")
  }
  
}
