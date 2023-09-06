//
//  PaymentViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

protocol backToCartDelegate: AnyObject {
  func backToCart()
}

class PaymentViewController: UIViewController {
  
  weak var delegate: backToCartDelegate?
  
  var cardData: [CardModel] = [
    CardModel(owner: "Irfanul Arifa", number: "4242 4242 4242 4242", cvv: "123", expMonth: 12, expYear: 25),
    CardModel(owner: "Irfanul Arifa", number: "5151 5151 5151 5151", cvv: "123", expMonth: 12, expYear: 25),
    CardModel(owner: "Irfanul Arifa", number: "5151 5151 5151 5151", cvv: "123", expMonth: 12, expYear: 25),
    CardModel(owner: "Irfanul Arifa", number: "5151 5151 5151 5151", cvv: "123", expMonth: 12, expYear: 25)
  ]
  
  @IBOutlet weak var paymentTxt: UILabel!{
    didSet {
      paymentTxt.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var creditCardCollection: UICollectionView!
  
  @IBOutlet weak var addNewCardBtn: UIButton!{
    didSet {
      addNewCardBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cardOwnerTxt: UILabel!{
    didSet {
      cardOwnerTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cardOwnerTxtField: UITextField!
  @IBOutlet weak var cardNumberTxt: UILabel!{
    didSet {
      cardNumberTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cardNumberTxtField: UITextField!{
    didSet {
      
    }
  }
  
  @IBOutlet weak var expTxt: UILabel!{
    didSet {
      expTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cvvTxt: UILabel!{
    didSet {
      cvvTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var expTxtField: UITextField!{
    didSet {
      expTxtField.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var cvvTxtField: UITextField!{
    didSet {
      cvvTxtField.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var saveCardBt: UIButton!{
    didSet {
      saveCardBt.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var addCard: UIButton!
  
  @IBOutlet weak var editCard: UIButton!{
    didSet {
      editCard.layer.borderWidth = 1
      editCard.layer.borderColor = CGColor.fromHex("#9775FA")
    }
  }
  
  @IBOutlet weak var deleteCard: UIButton!{
    didSet {
      deleteCard.layer.borderWidth = 1
      deleteCard.layer.borderColor = CGColor.fromHex("#FF0000")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    creditCardCollection.dataSource = self
    creditCardCollection.delegate = self
    
    creditCardCollection.register(UINib(nibName: "PaymentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PaymentCollectionViewCell")
  }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    delegate?.backToCart()
  }
  
  @IBAction func addNewCardClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "AddNewCardViewController")
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func saveCardClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func editCard(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "EditViewController")
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func deleteCard(_ sender: UIButton) {
    
  }
  
}

extension PaymentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cardData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = cardData[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentCollectionViewCell", for: indexPath) as? PaymentCollectionViewCell else { return UICollectionViewCell() }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      cell.configure(name: data.owner, number: data.number, expYear: data.expYear, expMonth: data.expMonth, cvc: data.cvv)
    }
    return cell
  }
}

extension PaymentViewController: UICollectionViewDelegate {
  
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let collectionViewWidth = collectionView.frame.width
    return CGSize(width: 300, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}

