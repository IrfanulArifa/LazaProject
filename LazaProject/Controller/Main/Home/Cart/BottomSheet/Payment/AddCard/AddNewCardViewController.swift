//
//  AddNewCardViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 08/08/23.
//

import UIKit
import CreditCardForm
import Stripe

protocol reloadDataPayment: AnyObject {
  func reloadData()
}

class AddNewCardViewController: UIViewController, STPPaymentCardTextFieldDelegate {
  
  let coreData = CoreDataManager()
  weak var delegate: reloadDataPayment?
  
  @IBOutlet weak var saveAs: UILabel!{
    didSet {
      saveAs.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var addNewCard: UILabel!{
    didSet {
      addNewCard.font = UIFont(name: "Poppins-SemiBold", size: 20)
    }
  }
  
  @IBOutlet weak var creditCardView: CreditCardFormView!
  
  @IBOutlet weak var cardPaymentTxtField: STPPaymentCardTextField! {
    didSet {
      cardPaymentTxtField.postalCodeEntryEnabled = false
    }
  }
  
  @IBOutlet weak var cardOwner: UILabel!{
    didSet {
      cardOwner.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cardOwnerTF: UITextField!{
    didSet {
      cardOwnerTF.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var saveCardBtn: UIButton!{
    didSet {
      saveCardBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var isPrimarySwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cardPaymentTxtField.delegate = self
    cardOwnerTF.addTarget(self, action: #selector(cardHolder), for: .editingChanged)
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
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func cardHolder() {
    creditCardView.cardHolderString = cardOwnerTF.text!
  }
  
  @IBAction func saveCard(_ sender: UIButton) {
    let text = cardPaymentTxtField
    let userid = UserDefaults.standard.integer(forKey: "userid")
    let card = CardModel(owner: cardOwnerTF.text!, number: (text?.cardNumber!)!, cvv: (text?.cvc)!, expMonth: String(text!.expirationMonth), expYear: String(text!.expirationYear), userId: userid)
    
    coreData.presentAlertFailed = {
      DispatchQueue.main.async { [weak self] in
        invalidSnackBar.make(in: self!.view, message: "Failed add Card", duration: .lengthLong).show()
      }
    }
    
    coreData.presentAlertSucces = {
      DispatchQueue.main.async { [weak self] in
        self?.showAlert(title: "Success", message: "Success Add Card") {
          self?.delegate?.reloadData()
          self?.navigationController?.popViewController(animated: true)
        }
      }
    }
    coreData.create(card)
  }
}
