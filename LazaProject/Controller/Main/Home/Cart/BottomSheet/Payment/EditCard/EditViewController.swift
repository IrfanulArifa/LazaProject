//
//  EditViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 06/09/23.
//

import UIKit
import CreditCardForm

protocol updateDataCard: AnyObject {
  func reloadData()
}

class EditViewController: UIViewController {
  
  // MARK: CreditCardFormView
  @IBOutlet weak var creditCardView: CreditCardFormView!
  weak var delegate: updateDataCard?
  let coreData = CoreDataManager()
  
  @IBOutlet weak var editCard: UILabel!{
    didSet {
      editCard.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var cardOwner: UILabel!{
    didSet {
      cardOwner.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cardNumber: UILabel!{
    didSet {
      cardNumber.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var exp: UILabel!{
    didSet {
      exp.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var ExpYear: UILabel!
  
  @IBOutlet weak var cvv: UILabel!{
    didSet {
      cvv.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var ownerTF: UITextField!
  @IBOutlet weak var numberTF: UITextField!
  @IBOutlet weak var expTF: UITextField!
  @IBOutlet weak var expYearTF: UITextField!
  @IBOutlet weak var cvvTF: UITextField!
  
  var nameCard: String?
  var numberCard: String?
  var expYearCard: String?
  var expMonthCard: String?
  var cvcCard: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ownerTF.addTarget(self, action: #selector(reactTF), for: .editingChanged)
    numberTF.addTarget(self, action: #selector(reactTF), for: .editingChanged)
    expTF.addTarget(self, action: #selector(reactTF), for: .editingChanged)
    cvvTF.addTarget(self, action: #selector(reactTF), for: .editingChanged)
    expYearTF.addTarget(self, action: #selector(reactTF), for: .editingChanged)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
      self?.setTF()
      self?.setCard()
    }
  }
  
  func setTF() {
    ownerTF.text = nameCard
    numberTF.text = numberCard
    expTF.text = expMonthCard
    cvvTF.text = cvcCard
    expYearTF.text = expYearCard
  }
  
  func setCard() {
    creditCardView.cardHolderString = nameCard!
    creditCardView.paymentCardTextFieldDidChange(cardNumber: numberCard, expirationYear: UInt(expYearCard!), expirationMonth: UInt(expMonthCard!), cvc: cvcCard)
  }
  
  @objc func reactTF(){
    creditCardView.cardHolderString = ownerTF.text ?? nameCard!
    creditCardView.paymentCardTextFieldDidChange(cardNumber: numberTF.text ?? numberCard!, expirationYear: UInt(expYearTF.text ?? expYearCard!), expirationMonth: UInt(expTF.text ?? expMonthCard!), cvc: cvvTF.text ?? cvcCard!)
  }
  
  func configure(name: String, number: String, expYear: String, expMonth: String, cvc: String) {
    self.nameCard = name
    self.numberCard = number
    self.expYearCard = expYear
    self.expMonthCard = expMonth
    self.cvcCard = cvc
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func saveCard(_ sender: UIButton) {
    let userid = UserDefaults.standard.integer(forKey: "userid")
    let card = CardModel(owner: ownerTF.text!, number: numberTF.text!, cvv: cvvTF.text!, expMonth: expTF.text!, expYear: expYearTF.text!, userId: userid)
    coreData.presentAlertFailed = {
      DispatchQueue.main.async { [weak self] in
        invalidSnackBar.make(in: self!.view, message: "Failed Edit Card", duration: .lengthLong).show()
      }
    }
    
    coreData.presentAlertSucces = {
      DispatchQueue.main.async { [weak self] in
        self?.showAlert(title: "Success!", message: "Edit Card Success"){
          self?.delegate?.reloadData()
          self?.navigationController?.popViewController(animated: true)
        }
      }
    }
    coreData.updateData(card, numberCard: numberTF.text!)
  }
}
