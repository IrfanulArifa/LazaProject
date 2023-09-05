//
//  SideMenuViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 02/08/23.
//

import UIKit
import SideMenu
import SDWebImage

protocol goToTabBarDelegate: AnyObject {
  func goToWishlist()
  func goToCart()
  func goToProfile()
  func goToChangePassword()
}

class SideMenuViewController: UIViewController {
  var loginUser: DataClass?
  weak var delegate: goToTabBarDelegate?
  
  @IBOutlet weak var sideMenuPersonName: UILabel!
  @IBOutlet weak var personPict: UIImageView!
  @IBOutlet weak var sunImage: UIImageView!
  @IBOutlet weak var switchBtn: UISwitch!
  func profilConfigure(data: DataClass){
    loginUser = data
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setImageProfile()
    checkDarkMode()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setImageProfile()
    checkDarkMode()
  }
  
  func checkDarkMode() {
    let isDarkMode = UserDefaults.standard.bool(forKey: "darkmode")
    if isDarkMode {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let appDelegate = windowScene.windows.first
        appDelegate?.overrideUserInterfaceStyle = .dark
      }
      switchBtn.isOn = true
    } else {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let appDelegate = windowScene.windows.first
        appDelegate?.overrideUserInterfaceStyle = .light
      }
      switchBtn.isOn = false
    }
  }
  
  func setImageProfile() {
    let data = UserDefaults.standard
    sideMenuPersonName.text = data.string(forKey: "fullname")
    if data.string(forKey: "image") != "Dummy" {
      let imageURL = URL(string: data.string(forKey: "image") ?? "")
      personPict.sd_setImage(with: imageURL)
    } else {
      personPict.image = UIImage(systemName: "person.fill")
    }
  }
  
  @IBAction func switchClicked(_ sender: UISwitch) {
    if sender.isOn {
      UserModel.darkmode = true
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let appDelegate = windowScene.windows.first
        appDelegate?.overrideUserInterfaceStyle = .dark
      }
    } else {
      UserModel.darkmode = false
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let appDelegate = windowScene.windows.first
        appDelegate?.overrideUserInterfaceStyle = .light
      }
    }
  }
  
  @IBAction func orderClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.goToCart()
  }
  
  @IBAction func myCardsClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.goToProfile()
  }
  
  @IBAction func wishlistClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.goToWishlist()
  }
  
  @IBAction func changePasswordClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.goToChangePassword()
  }
  
  @IBAction func logoutClicked(_ sender: UIButton) {
    showValidation(title: "Logout", message: "Are you Sure ?") {
      self.logout()
    }
  }
  
  private func logout() {
    if UserModel.deleteAll() {
      UserModel.stateLogin = false
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
      let nav = UINavigationController(rootViewController: vc)
      nav.setNavigationBarHidden(true, animated: false)
      nav.hidesBottomBarWhenPushed = true
      self.view.window?.windowScene?.keyWindow?.rootViewController = nav
    }
  }
}
