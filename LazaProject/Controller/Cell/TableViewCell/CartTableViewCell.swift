//
//  CartTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

protocol deleteCart{
  func deleteCart(index: IndexPath, id: Int)
}

class CartTableViewCell: UITableViewCell {
  
  let viewModel = CartViewModel()
  let sizeModel = ViewModel()
  var productId : Int?
  var sizeId : String?
  var sizesData : Int?
  var indexData : IndexPath?
  
  var delegate: deleteCart?
  
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
    print("productId = ", productID, "SizeId = ", sizeID)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func arrowUpClicked(_ sender: UIButton) {
    

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
      self.viewModel.reduceCart(productID: self.productId!, sizeID: self.sizesData!) { [self] response in
        if response != nil {
          DispatchQueue.main.async {
            self.valueTxt.text = String(response!.quantity)
          }
        } else {
          delegate?.deleteCart(index: indexData!, id: productId!)
        }
      } onError: { error in
        DispatchQueue.main.async {
          print(error)
        }
      }
    }
  }
}
