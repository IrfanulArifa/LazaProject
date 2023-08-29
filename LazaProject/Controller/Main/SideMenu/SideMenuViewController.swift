//
//  SideMenuViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 02/08/23.
//

import UIKit
import SideMenu
import SDWebImage

class SideMenuViewController: UIViewController {
  var loginUser: DataClass?
  let appDelegate = UIApplication.shared.windows.first
  
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
  
  @IBAction func accountInformationClicked(_ sender: UIButton) {
  }
  
  @IBAction func passwordClicked(_ sender: UIButton) {
    goToProfile()
  }
  
  func goToProfile() {
    let wishlistVC = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "CardViewController") as! ProfileViewController
    
    let Homepage = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main)
    let vc: UITabBarController = Homepage.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    vc.selectedIndex = 3
    let navBar = vc.selectedViewController as? UINavigationController
    
    navBar?.pushViewController(wishlistVC, animated: true)
    
    self.view.window?.windowScene?.keyWindow?.rootViewController = vc
  }
  
  @IBAction func orderClicked(_ sender: UIButton) {
    let wishlistVC = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
    
    let Homepage = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main)
    let vc: UITabBarController = Homepage.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    vc.selectedIndex = 1
    let navBar = vc.selectedViewController as? UINavigationController
    
    navBar?.pushViewController(wishlistVC, animated: true)
    
    self.view.window?.windowScene?.keyWindow?.rootViewController = vc
  }
  
  @IBAction func myCardsClicked(_ sender: UIButton) {
    let wishlistVC = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "CardViewController") as! ProfileViewController
    
    let Homepage = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main)
    let vc: UITabBarController = Homepage.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    vc.selectedIndex = 3
    let navBar = vc.selectedViewController as? UINavigationController
    
    navBar?.pushViewController(wishlistVC, animated: true)
    
    self.view.window?.windowScene?.keyWindow?.rootViewController = vc
  }
  
  @IBAction func wishlistClicked(_ sender: UIButton) {
    let wishlistVC = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
    
    let Homepage = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main)
    let vc: UITabBarController = Homepage.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    vc.selectedIndex = 1
    let navBar = vc.selectedViewController as? UINavigationController
    
    navBar?.pushViewController(wishlistVC, animated: true)
    
    self.view.window?.windowScene?.keyWindow?.rootViewController = vc
  }
  
  @IBAction func settingsClicked(_ sender: UIButton) {
  }
  
  func goToUpdateProfile(){
  }
  
  @IBAction func logoutClicked(_ sender: UIButton) {
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
