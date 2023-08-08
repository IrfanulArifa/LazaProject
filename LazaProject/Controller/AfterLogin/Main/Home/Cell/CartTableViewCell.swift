//
//  CartTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
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
  
  var valueItem = 1
  
  override func awakeFromNib() {
    super.awakeFromNib()
    valueTxt.text = String(valueItem)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func arrowUpClicked(_ sender: UIButton) {
    valueItem += 1
    valueTxt.text = String(valueItem)
  }
  
  @IBAction func arrowDownClicked(_ sender: UIButton) {
    if valueItem < 1 {
      valueItem = 0
    } else {
      valueItem -= 1
      valueTxt.text = String(valueItem)
    }
  }
  
}
