//
//  SideMenuViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 02/08/23.
//

import UIKit
import SideMenu

//protocol blurEffectDelegate: AnyObject {
//  func blurEffectActivated()
//  func blurEffectDeactivated()
//}

class SideMenuViewController: UIViewController {
  var loginUser: DataClass?
  let appDelegate = UIApplication.shared.windows.first
  
  @IBOutlet weak var sideMenuPersonName: UILabel!
  
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
    
    sideMenuPersonName.text = UserDefaults.standard.string(forKey: "username")
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
    let wishlistVC = UIStoryboard(name: "HomepageViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
    
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
  
  @IBAction func logoutClicked(_ sender: UIButton) {
    if UserModel.deleteAll() {
      UserModel.stateLogin = false
      let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
}
