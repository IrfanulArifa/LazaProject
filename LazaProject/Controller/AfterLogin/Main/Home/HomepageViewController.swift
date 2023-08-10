//
//  HomepageViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
// Done

import UIKit
import SDWebImage
import SideMenu
import SnackBar


class HomepageViewController: UIViewController, UINavigationControllerDelegate {
  // MARK: Assign View Model
  let viewModel = ViewModel()
  
  @IBOutlet weak var homeTableView: UITableView!
//  weak var delegate: blurEffectDelegate?
  
  @IBOutlet weak var blurEffect: UIVisualEffectView!{
    didSet {
      blurEffect.isHidden = true
    }
  }
  @IBOutlet weak var searchBarStyle: UISearchBar!{
    didSet{ searchBarStyle.searchBarStyle = .minimal } // Change Bar Style to Minimal
  }
  
  // MARK: Connecting Collection into View
  @IBOutlet weak var categoryTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    AppSnackBar.make(in: self.view, message: "Login is Successful", duration: .lengthLong).show()
    
    categoryTableView.dataSource = self
    categoryTableView.delegate = self
    categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    categoryTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    
    
    // Closure that Reload Collection Data
    viewModel.reloadProduct = {
      DispatchQueue.main.async {
        self.categoryTableView.reloadData()
      }
    }
    // Closure that Reload Collection Data
    viewModel.reloadCategory = {
      DispatchQueue.main.async {
        self.categoryTableView.reloadData()
      }
    }
    
    // Load Data From API
    viewModel.loadData()
    
    
    
    // Setup Tab Bar item Function Calling
    setupTabBarItemImage()
    
  }
  
  // Making a Function that Transform TabBar when Clicked from Logo into Text
  private func setupTabBarItemImage() {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = "Home"
    label.font = UIFont(name: "Inter-Medium", size: 11)
    label.sizeToFit()
    
    tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
    tabBarItem.selectedImage = UIImage(view: label)
  }
  
  @IBAction func MenuButtonClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController")
    let sideMenu = SideMenuNavigationController(rootViewController: vc)
    sideMenu.delegate = self
    sideMenu.presentationStyle = .menuSlideIn
    sideMenu.leftSide = true
    sideMenu.menuWidth = 330
    present(sideMenu, animated: true)
  }
}

// MARK: Extension that Counting DataSource
extension HomepageViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row < 1 {
      guard let cellA = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else { return UITableViewCell() }
      cellA.configure(viewModel.welcome)
      return cellA
    } else {
      guard let cellB = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else { return UITableViewCell() }
      cellB.delegate = self
      cellB.configuring(viewModel.welcomeElement)
      return cellB
    }
  }
}

extension HomepageViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row < 1 {
      return 150
    } else {
      return UITableView.automaticDimension
    }
  }
}

extension HomepageViewController: ProductTableViewCellDelegate {
  func productDidSelectItemAt(didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: viewModel.welcomeElement[indexPath.item])
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension HomepageViewController: SideMenuNavigationControllerDelegate {
  func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
    blurEffect.isHidden = false
  }
  func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
    blurEffect.isHidden = true
  }
}
