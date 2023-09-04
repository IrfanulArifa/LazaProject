//
//  UpdateAddressViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 30/08/23.
//

import UIKit

class UpdateAddressViewController: UIViewController {
  
  var addressData: AllAddressData?
  let viewModel = AddressViewModel()
  let refreshModel = RefreshTokenViewModel()
  
  //MARK: Label
  @IBOutlet weak var updateAddress: UILabel!{
    didSet {
      updateAddress.font = UIFont(name: "Poppins-SemiBold", size: 20)
    }
  }
  
  @IBOutlet weak var name: UILabel!{
    didSet{
      name.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var country: UILabel!{
    didSet{
      country.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var city: UILabel!{
    didSet{
      city.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var phoneNumber: UILabel!{
    didSet{
      phoneNumber.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var savePrimary: UILabel!{
    didSet{
      savePrimary.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  //MARK: Text Field
  @IBOutlet weak var nameTF: UITextField!{
    didSet{
      nameTF.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var countryTF: UITextField!{
    didSet{
      countryTF.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var cityTF: UITextField!{
    didSet{
      cityTF.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var phoneTF: UITextField!{
    didSet{
      phoneTF.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  //MARK: Switch
  @IBOutlet weak var SwitchButton: UISwitch!
  
  //MARK: Button
  @IBOutlet weak var updateBtn: UIButton!{
    didSet {
      updateBtn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  func configure(data: AllAddressData){
    addressData = data
  }
  
  func switchCheck() -> Bool {
    if SwitchButton.isOn {
      return true
    } else {
      return false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTF.text = addressData?.receiverName
    countryTF.text = addressData?.country
    cityTF.text = addressData?.city
    phoneTF.text = addressData?.phoneNumber
    if addressData?.isPrimary != nil {
      SwitchButton.isOn = true
    } else {
      SwitchButton.isOn = false
    }
    refreshModel.refreshToken()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    refreshModel.refreshToken()
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  @IBAction func updateAddressClicked(_ sender: UIButton) {
    let isValid = switchCheck()
    viewModel.updateAddress(idAddress: addressData!.id, country: countryTF.text!, city: cityTF.text!, receiverName: nameTF.text!, number: phoneTF.text!, isPrimary: isValid) { response in
      DispatchQueue.main.async {
        self.showAlert(title: "Success", message: "Update data Successfull"){
          self.dismiss(animated: true)
        }
      }
    } onError: { error in
      DispatchQueue.main.async {
        self.showAlert(title: "Failed", message: "Update Data Failed")
      }
    }

  }
  
}
