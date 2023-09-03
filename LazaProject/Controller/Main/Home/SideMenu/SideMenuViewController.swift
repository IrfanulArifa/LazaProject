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
    let currentTraitCollection = self.traitCollection
    if currentTraitCollection.userInterfaceStyle == .dark {
      switchBtn.isOn = true
    } else {
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
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let appDelegate = windowScene.windows.first
        appDelegate?.overrideUserInterfaceStyle = .dark
      }
    } else {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        let appDelegate = windowScene.windows.first
        appDelegate?.overrideUserInterfaceStyle = .light
      }
    }
  }
  
  @IBAction func orderClicked(_ sender: UIButton) {
    delegate?.goToCart()
    self.dismiss(animated: true)
  }
  
  @IBAction func myCardsClicked(_ sender: UIButton) {
    delegate?.goToProfile()
    self.dismiss(animated: true)
  }
  
  @IBAction func wishlistClicked(_ sender: UIButton) {
    delegate?.goToWishlist()
    self.dismiss(animated: true)
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
