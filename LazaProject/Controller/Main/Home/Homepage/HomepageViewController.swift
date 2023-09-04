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
import SkeletonView


class HomepageViewController: UIViewController, UINavigationControllerDelegate {
  // MARK: Assign View Model
  let viewModel = ViewModel()
  let loginModel = LoginViewModel()
  var isValidLogin = false
  
  @IBOutlet var homeView: UIView!
  
  @IBOutlet weak var helloLbl: UILabel!{
    didSet {
      helloLbl.font = UIFont(name: "Poppins-SemiBold", size: 28)
      //      helloLbl.isSkeletonable = true
      helloLbl.showAnimatedGradientSkeleton()
    }
  }
  
  @IBOutlet weak var welcomeTxt: UILabel!{
    didSet {
      welcomeTxt.font = UIFont(name: "Poppins-Regular", size: 20)
      //      welcomeTxt.isSkeletonable = true
      welcomeTxt.showAnimatedGradientSkeleton()
    }
  }
  
  @IBOutlet weak var blurEffect: UIVisualEffectView!{
    didSet {
      blurEffect.isHidden = true
    }
  }
  @IBOutlet weak var searchBarStyle: UISearchBar!{
    didSet{ searchBarStyle.searchBarStyle = .minimal
      searchBarStyle.showAnimatedGradientSkeleton()
    } // Change Bar Style to Minimal
  }
  
  // MARK: Connecting Collection into View
  @IBOutlet weak var categoryTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = false
    
    let token = UserDefaults.standard.string(forKey: "refresh_token")
    isValidToken(token: token!)
    
    validSnackBar.make(in: self.view, message: "Login is Successful", duration: .lengthLong).show()
    homeView.showAnimatedGradientSkeleton()
    // Setup Register Collection
    setup()
    
    reloadCollectionData()
    
    // Load Data From API
    viewModel.loadData()
    // Setup Tab Bar item Function Calling
    setupTabBarItemImage()
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    categoryTableView.refreshControl = refreshControl
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
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
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.showAlert(title: "Login Session Failed", message: "Please Re-login") {
            self.logout()
          }
        }
      } else {
        
      }
    } catch {
      print("An error occurred while decoding the JWT: \(error)")
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
  
  private func reloadCollectionData() {
    // Closure that Reload Collection Data
    viewModel.reloadProduct = {
      DispatchQueue.main.async { [unowned self] in
        self.categoryTableView.reloadData()
      }
    }
    // Closure that Reload Collection Data
    viewModel.reloadCategory = {
      DispatchQueue.main.async { [unowned self] in
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
  
  private func sideMenuClicked() {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
    let sideMenu = SideMenuNavigationController(rootViewController: vc)
    vc.delegate = self
    sideMenu.delegate = self
    sideMenu.presentationStyle = .menuSlideIn
    sideMenu.leftSide = true
    sideMenu.menuWidth = 330
    present(sideMenu, animated: true)
  }
  
  @objc func refreshTableView(){
    categoryTableView.refreshControl?.endRefreshing()
    categoryTableView.reloadData()
  }
  
  @IBAction func MenuButtonClicked(_ sender: UIButton) {
    sideMenuClicked()
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
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func productDidSelectItemAt(didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: viewModel.product[indexPath.item].id)
    self.navigationController?.pushViewController(vc, animated: true)
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
    let storyboard = UIStoryboard(name: "AllCategoryViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "SelectedBrandViewController") as? SelectedBrandViewController else { return }
    vc.configureBrand(name: viewModel.brand[indexPath.item].name, imageLogo: viewModel.brand[indexPath.item].logoURL)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func viewAllCategory() {
    let storyboard = UIStoryboard(name: "AllCategoryViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(identifier: "AllCategoryViewController") as? AllCategoryViewController else { return }
    vc.configureCategory(data: viewModel.brand)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension HomepageViewController: goToTabBarDelegate {
  func goToChangePassword() {
    let storyboard = UIStoryboard(name: "ChangePasswordView", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController else { return }
    vc.delegate = self
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func goToWishlist() {
    self.tabBarController?.selectedIndex = 1
  }
  
  func goToCart() {
    self.tabBarController?.selectedIndex = 2
  }
  
  func goToProfile() {
    self.tabBarController?.selectedIndex = 3
  }
}

extension HomepageViewController: accessSideMenuDelegate {
  func accessSideMenu() {
    sideMenuClicked()
  }
}
