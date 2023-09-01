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
  let appDelegate = UIApplication.shared.windows.first
  weak var delegate: goToTabBarDelegate?
  
  @IBOutlet weak var sideMenuPersonName: UILabel!
  @IBOutlet weak var personPict: UIImageView!
  
  @IBOutlet weak var sunImage: UIImageView!
  
  @IBOutlet weak var switchBtn: UISwitch!{
    didSet {
      if appDelegate?.overrideUserInterfaceStyle == .dark {
        switchBtn.isOn = true
      } else if appDelegate?.overrideUserInterfaceStyle == .light {
        switchBtn.isOn = false
      }
    }
  }
  
  func profilConfigure(data: DataClass){
    loginUser = data
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let data = UserDefaults.standard
    sideMenuPersonName.text = data.string(forKey: "fullname")
    let imageURL = URL(string: data.string(forKey: "image") ?? "")
    personPict.sd_setImage(with: imageURL)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UserModel.synchronize()
    sideMenuPersonName.text = UserDefaults.standard.string(forKey: "fullname")
    let imageURL = URL(string: UserDefaults.standard.string(forKey: "image") ?? "")
    personPict.sd_setImage(with: imageURL)
  }
  
  @IBAction func switchClicked(_ sender: UISwitch) {
    if sender.isOn {
      appDelegate?.overrideUserInterfaceStyle = .dark
      return
    } else {
      appDelegate?.overrideUserInterfaceStyle = .light
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
    logout()
  }
  
  private func logout() {
    if UserModel.deleteAll() {
      UserModel.stateLogin = false
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
      let nav = UINavigationController(rootViewController: vc)
      nav.setNavigationBarHidden(true, animated: false)
      nav.hidesBottomBarWhenPushed = true
      self.view.window?.windowScene?.keyWindow?.rootViewController = nav
    }
  }
}
