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
  
  @IBOutlet weak var saveCardInfo: UILabel!{
    didSet {
      saveCardInfo.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  
  @IBOutlet weak var saveCardBt: UIButton!{
    didSet {
      saveCardBt.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    creditCardCollection.dataSource = self
    creditCardCollection.delegate = self
    
    creditCardCollection.register(UINib(nibName: "PaymentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PaymentCollectionViewCell")
  }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
    delegate?.backToCart()
  }
  
  @IBAction func addNewCardClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "AddNewCardViewController", bundle: nil).instantiateViewController(withIdentifier: "AddNewCardViewController")
    storyboard.modalPresentationStyle = .fullScreen
    self.present(storyboard, animated: true)
  }
  @IBAction func saveCardClicked(_ sender: Any) {
    self.dismiss(animated: true)
  }
}

extension PaymentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentCollectionViewCell", for: indexPath) as? PaymentCollectionViewCell else { return UICollectionViewCell() }
    cell.configure()
    return cell
  }
}

extension PaymentViewController: UICollectionViewDelegate {
  
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 300, height: 180)
  }
}

