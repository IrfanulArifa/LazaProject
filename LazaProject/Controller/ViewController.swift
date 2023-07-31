//
//  ViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class ViewController: UIViewController {
  
  let viewModel = ViewModel()
  let userModel = UserModel()
  
  // MARK: View Settings -> Change Font Type
  @IBOutlet weak var titleTxt: UILabel!{
    didSet{ titleTxt.font = UIFont(name: "Inter", size: 25) }
  }
  
  @IBOutlet weak var subTitleTxt: UILabel!{
    didSet{ subTitleTxt.font = UIFont(name: "Inter", size: 15) }
  }
  
  @IBOutlet weak var menBtn: UIButton!{
    didSet{ menBtn.titleLabel!.font = UIFont(name: "Inter", size: 17) }
  }
  
  @IBOutlet weak var womenBtn: UIButton!{
    didSet{ womenBtn.titleLabel!.font = UIFont(name: "Inter", size: 17) }
  }
  
  @IBOutlet weak var skipBtn: UIButton!{
    didSet{ skipBtn.titleLabel!.font = UIFont(name: "Inter", size: 17) }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if UserDefaults.standard.bool(forKey: "state") {
      let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
  
  // MARK: Men Button When Clicked -> Change to Started View
  @IBAction func menBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "StartedViewController", bundle: nil).instantiateViewController(withIdentifier: "StartedViewController") as! StartedViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: Women Button When Clicked -> Change to Started View
  @IBAction func womenBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "StartedViewController", bundle: nil).instantiateViewController(withIdentifier: "StartedViewController") as! StartedViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: Skip Button When Clicked -> Change to Started View
  @IBAction func skipBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "StartedViewController", bundle: nil).instantiateViewController(withIdentifier: "StartedViewController") as! StartedViewController 
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
}

