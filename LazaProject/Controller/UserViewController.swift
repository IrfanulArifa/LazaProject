//
//  UserViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 29/07/23.
//

import UIKit

class UserViewController: UIViewController {
  
  @IBOutlet weak var usernameDefault: UILabel!{
    didSet {
      usernameDefault.text = UserDefaults.standard.string(forKey: "name")
    }
  }
  
  @IBOutlet weak var emailDefault: UILabel!{
    didSet {
      emailDefault.text = UserDefaults.standard.string(forKey: "email")
    }
  }
  
  @IBOutlet weak var phoneNumberDefault: UILabel!{
    didSet {
      phoneNumberDefault.text = UserDefaults.standard.string(forKey: "phonenumber")
    }
  }
  
  @IBOutlet weak var passwordDefault: UITextField!{
    didSet {
      passwordDefault.text = UserDefaults.standard.string(forKey: "password")
      passwordDefault.isSecureTextEntry = true
      passwordDefault.isEnabled = false
    }
  }
  
  @IBOutlet weak var eyedButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarItemImage() // Calling Function
    
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
      let storyboard = UIStoryboard(name: "StartedViewController", bundle: nil).instantiateViewController(withIdentifier: "StartedViewController") as! StartedViewController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
}
