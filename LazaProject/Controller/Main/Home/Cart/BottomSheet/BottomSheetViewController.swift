//
//  BottomSheetViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

protocol MoveIntoDelegate: AnyObject {
  func moveIntoDeliveries()
  func moveIntoPayment()
}

class BottomSheetViewController: UIViewController {
  
  weak var delegate : MoveIntoDelegate?
  private let viewModel = AddressViewModel()
  private let priceModel = CartViewModel()
  
  @IBOutlet weak var deliveryAddress: UILabel!{
    didSet {
      deliveryAddress.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var Alamat: UILabel!{
    didSet {
      Alamat.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var subAlamat: UILabel!{
    didSet {
      subAlamat.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var paymentMethod: UILabel!{
    didSet {
      paymentMethod.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var ccName: UILabel!{
    didSet {
      ccName.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var ccNum: UILabel!{
    didSet { ccNum.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var orderInfo: UILabel!{
    didSet { orderInfo.font = UIFont(name: "Poppins-Regular", size: 17) }
  }
  
  @IBOutlet weak var subTotal: UILabel!{
    didSet { subTotal.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  @IBOutlet weak var subtotalPrice: UILabel!{
    didSet {
      subtotalPrice.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var shippingCost: UILabel!{
    didSet {
      shippingCost.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var shippingCostPrice: UILabel!{
    didSet {
      shippingCostPrice.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var total: UILabel!{
    didSet {
      total.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var totalPrice: UILabel!{
    didSet {
      totalPrice.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    let token = UserDefaults.standard.string(forKey: "access_token")
    loadDataAddress()
    loadDataCart(token: token!)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let token = UserDefaults.standard.string(forKey: "access_token")
    loadDataAddress()
    loadDataCart(token: token!)
  }
  
  private func loadDataAddress() {
    viewModel.reloadData = {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        let data = self.viewModel.allAddressData
        for address in data {
          if address.isPrimary != nil {
            self.Alamat.text = address.country
            self.subAlamat.text = address.city
          }
        }
      }
    }
    viewModel.getAllAddress()
  }
  
  private func loadDataCart(token: String) {
    priceModel.reloadData = {
      DispatchQueue.main.async { [unowned self] in
        let data = self.priceModel.cartData?.orderInfo
        self.subtotalPrice.text = "Rp. \(data!.subTotal)"
        self.shippingCostPrice.text = "Rp. \(data!.shippingCost)"
        self.totalPrice.text = "Rp. \(data!.total)"
      }
    }
    priceModel.getAllCart(token: token)
  }
  
  @IBAction func deliveryAddressClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.moveIntoDeliveries()
  }
  
  @IBAction func paymentMethodClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.moveIntoPayment()
  }
}
