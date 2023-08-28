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
import JWTDecode


class HomepageViewController: UIViewController, UINavigationControllerDelegate {
  // MARK: Assign View Model
  let viewModel = ViewModel()
  let loginModel = LoginViewModel()
  var isValidLogin = false
  
  @IBOutlet weak var helloLbl: UILabel!{
    didSet { helloLbl.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
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
    
    let token = UserDefaults.standard.string(forKey: "access_token")
    isValidToken(token: token!)
    
    if isValidLogin {
      validSnackBar.make(in: self.view, message: "Login is Successful", duration: .lengthLong).show()
      // Setup Register Collection
      setup()

      reloadCollectionData()

      // Load Data From API
      viewModel.loadData()
    }
    
    // Setup Tab Bar item Function Calling
    setupTabBarItemImage()
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    categoryTableView.refreshControl = refreshControl
  }
  
  override func viewWillAppear(_ animated: Bool) {
    categoryTableView.reloadData()
  }
  
  private func setup() {
    categoryTableView.dataSource = self
    categoryTableView.delegate = self
    categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    categoryTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
  }
  
  private func isValidToken(token: String){
    do {
      let jwt = try decode(jwt: token)
      if jwt.expired {
        isValidLogin = false
        showAlert(title: "Invalid Token", message: "Please Re-Login!"){
          DispatchQueue.main.async {
            if UserModel.deleteAll() {
              UserModel.stateLogin = false
              let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
              self.navigationController?.pushViewController(storyboard, animated: true)
            }
          }
        }
      } else {
        isValidLogin = true
      }
    } catch {
      print("An error occurred while decoding the JWT: \(error)")
    }
  }
  
  private func reloadCollectionData() {
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
  
  @objc func refreshTableView(){
    categoryTableView.refreshControl?.endRefreshing()
    categoryTableView.reloadData()
  }
  
  @IBAction func MenuButtonClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
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
      cellA.delegate = self
      cellA.configure(viewModel.brand)
      return cellA
    } else {
      guard let cellB = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else { return UITableViewCell() }
      cellB.delegate = self
      cellB.configuring(viewModel.product)
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
  func viewAllProduct() {
    let storyboard = UIStoryboard(name: "AllProductViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "AllProductViewController") as? AllProductViewController else { return }
    vc.configureData(data: viewModel.product)
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
  
  func productDidSelectItemAt(didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: viewModel.product[indexPath.item].id)
    vc.modalPresentationStyle = .fullScreen
    
    self.present(vc, animated: true)
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

extension HomepageViewController: CategoryTableViewCellDelegate{
  func categoryDidSelectItemAt(didSelectItemAt indexPath: IndexPath) {
    
  }
  
  func viewAllCategory() {
    let storyboard = UIStoryboard(name: "AllCategoryViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(identifier: "AllCategoryViewController") as? AllCategoryViewController else { return }
    vc.configureCategory(data: viewModel.brand)
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
}
