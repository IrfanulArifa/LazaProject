//
//  UserViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 29/07/23.
//

import UIKit

class UserViewController: UIViewController {
  
  @IBOutlet weak var usernameDefault: UILabel!
  @IBOutlet weak var emailDefault: UILabel!
  @IBOutlet weak var phoneNumberDefault: UILabel!
  @IBOutlet weak var passwordDefault: UITextField!{
    didSet {
      passwordDefault.isSecureTextEntry = true
      passwordDefault.isEnabled = false
    }
  }
  
  @IBOutlet weak var eyedButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UserModel.synchronize()
    usernameDefault.text = UserDefaults.standard.string(forKey: "name")
    passwordDefault.text = UserDefaults.standard.string(forKey: "password")
    emailDefault.text = UserDefaults.standard.string(forKey: "email")
    phoneNumberDefault.text = UserDefaults.standard.string(forKey: "phonenumber")
    setupTabBarItemImage() // Calling Function
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UserModel.synchronize()
    usernameDefault.text = UserDefaults.standard.string(forKey: "name")
    passwordDefault.text = UserDefaults.standard.string(forKey: "password")
    emailDefault.text = UserDefaults.standard.string(forKey: "email")
    phoneNumberDefault.text = UserDefaults.standard.string(forKey: "phonenumber")
  }
  
  // MARK: Setup BarItem when Clicked Change into Text
  private func setupTabBarItemImage() {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = "User"
    label.font = UIFont(name: "Inter-Medium", size: 11)
    label.textColor = UIColor(named: "PurpleButton")
    label.sizeToFit()
    
    tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
    tabBarItem.selectedImage = UIImage(view: label)
  }
  
  @IBAction func eyeClicked(_ sender: UIButton) {
    if passwordDefault.isSecureTextEntry {
      eyedButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      passwordDefault.isSecureTextEntry = false
    } else if !passwordDefault.isSecureTextEntry{
      eyedButton.setImage(UIImage(systemName: "eye"), for: .normal)
      passwordDefault.isSecureTextEntry = true
    }
  }
  
  @IBAction func logoutButton(_ sender: UIButton) {
    if UserModel.deleteAll() {
      UserModel.stateLogin = false
      let storyboard = UIStoryboard(name: "StartedViewController", bundle: nil).instantiateViewController(withIdentifier: "StartedViewController") as! StartedViewController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
  
  @IBAction func editClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "UpdatePasswordViewController", bundle: nil).instantiateViewController(withIdentifier: "UpdatePasswordViewController") as! UpdatePasswordViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
}
