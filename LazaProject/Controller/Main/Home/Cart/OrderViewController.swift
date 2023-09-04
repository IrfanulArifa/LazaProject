//
//  OrderViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit
import SDWebImage

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
  
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet {
      indicatorLoading.isHidden = false
      indicatorLoading.startAnimating()
    }
  }
  
  @IBOutlet weak var dataKosong: UILabel!{
    didSet {
      dataKosong.font = UIFont(name: "Poppins-Regular", size: 20)
      dataKosong.isHidden = true
    }
  }
  
  let viewModel = CartViewModel()
  var indexData: Int?
  
  
  lazy var bottomSheet = UIStoryboard(name: "BottomSheetViewController", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let userToken = UserDefaults.standard.string(forKey: "access_token")
    
    DispatchQueue.main.async {
      self.stopAnimation()
      self.setupTabBarItemImage() // Calling Function
      
      self.cardTableView.delegate = self
      self.cardTableView.dataSource = self
      self.cardTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
      
      self.loadData(token: userToken!)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let userToken = UserDefaults.standard.string(forKey: "access_token")
    DispatchQueue.main.async{ [self] in
      loadData(token: userToken!)
    }
  }
  
  func stopAnimation(){
    indicatorLoading.stopAnimating()
    indicatorLoading.isHidden = true
  }
  
  func loadData(token: String){
    viewModel.reloadData = {
      DispatchQueue.main.async {
        self.cardTableView.reloadData()
        self.totalCart.text = "Total: \(String(describing: self.viewModel.cartData!.orderInfo.total))"
        if self.viewModel.cartData?.orderInfo.total == 0 {
          self.dataKosong.isHidden = false
        } else {
          self.dataKosong.isHidden = true
        }
      }
    }
    viewModel.getAllCart(token: token)
  }
  
  func reloadHarga(token: String){
    viewModel.reloadData = {
      DispatchQueue.main.async {
        self.totalCart.text = "Total: \(String(describing: self.viewModel.cartData!.orderInfo.total))"
        if self.viewModel.cartData?.orderInfo.total == 0 {
          self.dataKosong.isHidden = false
        } else {
          self.dataKosong.isHidden = true
        }
      }
    }
    viewModel.getAllCart(token: token)
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
    print("Product count: \(viewModel.cartData?.products?.count ?? -1)")
    return viewModel.cartData?.products?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = viewModel.cartData?.products?[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as? CartTableViewCell else { return UITableViewCell() }
    cell.cartLabel.text = "\(String(describing: data!.productName)) (\(String(describing: data!.size)))"
    cell.cartPrice.text = "Rp. \(String(describing: data!.price))"
    cell.valueTxt.text = "\(String(describing: data!.quantity))"
    cell.productImage.sd_setImage(with: URL(string: data!.imageURL))
    cell.configure(productID: data!.id, sizeID: data!.size, index: indexPath)
    indexData = indexPath.row
    cell.delegate = self
    return cell
  }
}

extension OrderViewController: MoveIntoDelegate {
  func moveIntoDeliveries() {
    guard let storyboard = UIStoryboard(name: "AllAddressViewController", bundle: nil).instantiateViewController(withIdentifier: "AllAddressViewController") as? AllAddressViewController else { return }
    storyboard.delegate = self
//    storyboard.modalPresentationStyle = .fullScreen
    self.navigationController?.pushViewController(storyboard, animated: true)
//    self.present(storyboard, animated: true)
  }
  
  func moveIntoPayment() {
    guard let storyboard = UIStoryboard(name: "PaymentViewController", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController else { return }
    storyboard.delegate = self
//    storyboard.modalPresentationStyle = .fullScreen
    self.navigationController?.pushViewController(storyboard, animated: true)
//    self.present(storyboard, animated: true)
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
  func setAddressDelivery(data: AllAddressData) {
    let navVC = UINavigationController(rootViewController: bottomSheet)
    let vc = bottomSheet as? BottomSheetViewController
    vc?.delegate = self
    if let sheet = navVC.sheetPresentationController {
      sheet.detents = [.medium()]
    }
    vc?.Alamat.text = data.country
    vc?.subAlamat.text = data.city
    self.present(navVC, animated: true)
  }
  
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

extension OrderViewController: deleteCart {
  func updateTotal() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      let token = UserDefaults.standard.string(forKey: "access_token")
      self.reloadHarga(token: token!)
    }
  }
  func deleteCart(index: IndexPath, id: Int, size: String) {
    self.viewModel.cartData?.products!.removeAll(where: { cart in
      cart.id == id && cart.size == size
    })
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.cardTableView.deleteRows(at: [index], with: .left)
      self.totalCart.text = "Total: \(String(describing: self.viewModel.cartData!.orderInfo.total))"
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
      self.cardTableView.reloadData()
    }
  }
}
