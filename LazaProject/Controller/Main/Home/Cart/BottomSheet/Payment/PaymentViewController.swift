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
  
  var indexScroll: IndexPath? = [0]
  let coreData = CoreDataManager()
  
  var cardData: [CardModel] = []
  
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
  
  @IBOutlet weak var cardOwnerTxtField: UITextField!{
    didSet {
      cardOwnerTxtField.isEnabled = false
    }
  }
  @IBOutlet weak var cardNumberTxt: UILabel!{
    didSet {
      cardNumberTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var cardNumberTxtField: UITextField!{
    didSet {
      cardNumberTxtField.isEnabled = false
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
      expTxtField.isEnabled = false
    }
  }
  @IBOutlet weak var cvvTxtField: UITextField!{
    didSet {
      cvvTxtField.font = UIFont(name: "Poppins-Regular", size: 15)
      cvvTxtField.isEnabled = false
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
    
    coreData.retrieve { data in
      self.cardData = data
    }
    let userId = UserDefaults.standard.string(forKey: "userid")
    
    let data = cardData[0]
    cardOwnerTxtField.text = data.owner
    cardNumberTxtField.text = data.number
    expTxtField.text = data.expMonth + "/" + data.expYear
    DispatchQueue.main.async {
      self.cvvTxtField.text = "\(String(describing: userId!))"
    }
  }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    delegate?.backToCart()
  }
  
  @IBAction func addNewCardClicked(_ sender: UIButton) {
    guard let storyboard = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "AddNewCardViewController") as? AddNewCardViewController else { return }
    storyboard.delegate = self
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func saveCardClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func editCard(_ sender: UIButton) {
    if indexScroll?.item == 0 {
      let data = cardData[0]
      guard let storyboard = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
      storyboard.configure(name: data.owner, number: data.number, expYear: data.expYear, expMonth: data.expMonth, cvc: data.cvv)
      storyboard.delegate = self
      self.navigationController?.pushViewController(storyboard, animated: true)
    } else {
      let data = cardData[indexScroll!.item]
      guard let storyboard = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        storyboard.configure(name: data.owner, number: data.number, expYear: data.expYear, expMonth: data.expMonth, cvc: data.cvv)
      }
      storyboard.delegate = self
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
  
  @IBAction func deleteCard(_ sender: UIButton) {
    let data = cardData[indexScroll!.item]
    coreData.delete(data) {
      
    }
  }
  
}

extension PaymentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cardData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    indexScroll = indexPath
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
    return CGSize(width: 300, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let data = cardData[indexScroll!.item]
    cardOwnerTxtField.text = data.owner
    cardNumberTxtField.text = data.number
    expTxtField.text = data.expMonth + "/" + data.expYear
    cvvTxtField.text = data.cvv
  }
}

extension PaymentViewController: updateDataCard, reloadDataPayment {
  func reloadData() {
    coreData.retrieve { data in
      self.cardData = data
    }
    let data = cardData[0]
    cardOwnerTxtField.text = data.owner
    cardNumberTxtField.text = data.number
    expTxtField.text = data.expMonth + "/" + data.expYear
    cvvTxtField.text = data.cvv
    
    creditCardCollection.reloadData()
  }
}
