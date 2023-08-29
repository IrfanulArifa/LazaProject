//
//  OrderViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit

class OrderViewController: UIViewController {
  
  @IBOutlet weak var cardTableView: UITableView!
  
  @IBOutlet weak var cartTitle: UILabel!{
    didSet {
      cartTitle.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var totalCart: UILabel!{
    didSet {
      totalCart.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var checkoutButton: UIButton!{
    didSet {
      checkoutButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  lazy var bottomSheet = UIStoryboard(name: "BottomSheetViewController", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarItemImage() // Calling Function
    
    cardTableView.delegate = self
    cardTableView.dataSource = self
    
    cardTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }
  
  // MARK: Setup BarItem when Clicked Change into Text
  private func setupTabBarItemImage() {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = "Order"
    label.font = UIFont(name: "Inter-Medium", size: 11)
    label.sizeToFit()
    
    tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
    tabBarItem.selectedImage = UIImage(view: label)
  }
  
  @IBAction func chevronClicked(_ sender: Any) {
    let navVC = UINavigationController(rootViewController: bottomSheet)
    let vc = bottomSheet as? BottomSheetViewController
    vc?.delegate = self
    if let sheet = navVC.sheetPresentationController {
      sheet.detents = [.medium()]
    }
    self.present(navVC, animated: true)
  }
  @IBAction func checkoutClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "OrderConfirmedViewController", bundle: nil).instantiateViewController(withIdentifier: "OrderConfirmedViewController")
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
}

extension OrderViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
  }
}

extension OrderViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as? CartTableViewCell else { return UITableViewCell() }
    return cell
  }
}

extension OrderViewController: MoveIntoDelegate {
  func moveIntoDeliveries() {
    guard let storyboard = UIStoryboard(name: "AllAddressViewController", bundle: nil).instantiateViewController(withIdentifier: "AllAddressViewController") as? AllAddressViewController else { return }
    storyboard.delegate = self
    storyboard.modalPresentationStyle = .fullScreen
    
    self.present(storyboard, animated: true)
  }
  
  func moveIntoPayment() {
    guard let storyboard = UIStoryboard(name: "ChoosePaymentViewController", bundle: nil).instantiateViewController(withIdentifier: "ChoosePaymentViewController") as? ChoosePaymentViewController else { return }
    storyboard.delegate = self
    storyboard.modalPresentationStyle = .fullScreen
    
    self.present(storyboard, animated: true)
  }
}

extension OrderViewController: backToCartDelegate{
  func backToCart() {
    let navVC = UINavigationController(rootViewController: bottomSheet)
    let vc = bottomSheet as? BottomSheetViewController
    vc?.delegate = self
    if let sheet = navVC.sheetPresentationController {
      sheet.detents = [.medium()]
    }
    self.present(navVC, animated: true)
  }
}

extension OrderViewController: backToCartfromAddressDelegate{
  func backToCartFromAddress() {
    let navVC = UINavigationController(rootViewController: bottomSheet)
    let vc = bottomSheet as? BottomSheetViewController
    vc?.delegate = self
    if let sheet = navVC.sheetPresentationController {
      sheet.detents = [.medium()]
    }
    self.present(navVC, animated: true)
  }
}
