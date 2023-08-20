//
//  AddressViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit



class AddressViewController: UIViewController {
  
  
  
  @IBOutlet weak var addressTitle: UILabel!{
    didSet {
      addressTitle.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var nameTxt: UILabel!{
    didSet {
      nameTxt.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var nameTxtField: UITextField!{
    didSet {
      nameTxtField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  @IBOutlet weak var countryTxtField: UITextField!{
    didSet {
      countryTxtField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  @IBOutlet weak var countryTxt: UILabel!{
    didSet {
      countryTxt.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var cityTxt: UILabel!{
    didSet {
      cityTxt.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var cityTxtField: UITextField!{
    didSet {
      cityTxtField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  
  @IBOutlet weak var phoneNumberTxt: UILabel!{
    didSet {
      phoneNumberTxt.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var phoneTxtField: UITextField!{
    didSet {
      phoneTxtField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  
  @IBOutlet weak var addressTxt: UILabel!{
    didSet {
      addressTxt.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var addressTxtField: UITextField!{
    didSet {
      addressTxtField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  
  @IBOutlet weak var saveAsPrimaryTxt: UILabel!{
    didSet {
      saveAsPrimaryTxt.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func saveAddressClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
