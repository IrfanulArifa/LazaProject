//
//  CartTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

protocol deleteCart{
  func deleteCart(index: IndexPath, id: Int, size: String)
  func reloadData()
  func updateTotal()
}

class CartTableViewCell: UITableViewCell {
  
  let viewModel = CartViewModel()
  let sizeModel = ViewModel()
  var productId : Int?
  var sizeId : String?
  var sizesData : Int?
  var indexData : IndexPath?
  
  var delegate: deleteCart?
  let userToken = UserDefaults.standard.string(forKey: "access_token")
  
  @IBOutlet weak var cartLabel: UILabel!{
    didSet {
      cartLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
    }
  }
  
  @IBOutlet weak var cartPrice: UILabel!{
    didSet {
      cartPrice.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var valueTxt: UILabel!{
    didSet {
      valueTxt.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var productImage: UIImageView!
  
  func configure(productID: Int, sizeID: String, index: IndexPath){
    productId = productID
    sizeId = sizeID
    indexData = index
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func deleteCart(_ sender: UIButton) {
    sizeModel.getAllSize { success in
      let sizes = success.data
      for size in sizes {
        if size.size == self.sizeId {
          self.sizesData = size.id
          break
        }
      }
      self.viewModel.deleteCart(token: self.userToken!, productID: self.productId!, sizeID: self.sizesData!)
//      self.delegate?.updateTotal()
      self.delegate?.deleteCart(index: self.indexData!, id: self.productId!, size: self.sizeId!)
    }
  }
  
  @IBAction func arrowUpClicked(_ sender: UIButton) {
    sizeModel.getAllSize { success in
      let sizes = success.data
      for size in sizes {
        if size.size == self.sizeId {
          self.sizesData = size.id
          break
        }
      }
      self.viewModel.insertCartData(token: self.userToken!, productID: self.productId!, sizeID: self.sizesData!) { [self] response in
        DispatchQueue.main.async {
          self.valueTxt.text = String(response!.quantity)
          self.delegate?.reloadData()
        }
      } onError: { error in
        print("Error: \(error)")
      }
    }
  }
  
  @IBAction func arrowDownClicked(_ sender: UIButton) {
    sizeModel.getAllSize { success in
      let sizes = success.data
      for size in sizes {
        if size.size == self.sizeId {
          self.sizesData = size.id
          break
        }
      }
      self.viewModel.reduceCart(token: self.userToken!, productID: self.productId!, sizeID: self.sizesData!) { [self] response in
        if response != nil {
          DispatchQueue.main.async {
            self.valueTxt.text = String(response!.quantity)
            self.delegate?.reloadData()
          }
        } else {
          DispatchQueue.main.async { [self] in
            delegate?.deleteCart(index: indexData!, id: productId!, size: sizeId!)
            self.delegate?.reloadData()
          }
        }
      } onError: { error in
        DispatchQueue.main.async {
          print(error)
        }
      }
    }
  }
}
