//
//  AllAddressViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 09/08/23.
//

import UIKit

protocol backToCartfromAddressDelegate: AnyObject {
  func backToCartFromAddress()
  func setAddressDelivery(data: AllAddressData)
}

class AllAddressViewController: UIViewController {
  
  weak var delegate: backToCartfromAddressDelegate?
  let viewModel = AddressViewModel()
  let refreshModel = RefreshTokenViewModel()
  
  @IBOutlet weak var allAddress: UILabel!{
    didSet {
      allAddress.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  @IBOutlet weak var addressTableView: UITableView!{
    didSet {
      addressTableView.delegate = self
      addressTableView.dataSource = self
      
      addressTableView.register(UINib(nibName: "AllAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AllAddressTableViewCell")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refreshModel.refreshToken()
    self.tabBarController?.tabBar.isHidden = true
    loadData()
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    addressTableView.refreshControl = refreshControl
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refreshModel.refreshToken()
    loadData()
  }
  
  func loadData(){
    viewModel.reloadData = { [weak self] in
      DispatchQueue.main.async {
        self?.addressTableView.reloadData()
      }
    }
    
    viewModel.getAllAddress()
  }
  
  @objc func refreshTableView(){
    addressTableView.refreshControl?.endRefreshing()
    loadData()
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    delegate?.backToCartFromAddress()
  }
  
  @IBAction func addNewAddressClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: "AddressViewController")
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
}

extension AllAddressViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.allAddressData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = viewModel.allAddressData[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllAddressTableViewCell") as? AllAddressTableViewCell else { return UITableViewCell() }
    cell.nameAddress.text = data.receiverName
    cell.cityAddress.text = data.city
    cell.numberAddress.text = String(data.phoneNumber)
    cell.streetAddress.text = data.country
    for _ in viewModel.allAddressData {
      if data.isPrimary != nil {
        cell.isPrimary.isHidden = false
      } else {
        cell.isPrimary.isHidden = true
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let data = viewModel.allAddressData[indexPath.row]
    
    let deleteData = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.viewModel.deleteAddress(idAddress: data.id, completion: { response in
          DispatchQueue.main.async {
            self.viewModel.allAddressData.removeAll {$0.id == data.id }
            self.addressTableView.deleteRows(at: [indexPath], with: .left)
            self.showAlert(title: "Success", message: (response?.data.capitalized)!)
          }
        }, onError: { error in
          DispatchQueue.main.async {
            self.showAlert(title: "Failed", message: "Data Gagal Dihapus!")
          }
        })
      }
      completionHandler(true)
    }
    deleteData.backgroundColor = .systemRed
    
    let updateData = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler)  in
      DispatchQueue.main.async { [unowned self] in
        let storyboard = UIStoryboard(name: "Address", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "UpdateAddressViewController") as? UpdateAddressViewController else { return }
        vc.configure(data: data)
        self?.navigationController?.pushViewController(vc, animated: true)
      }
      completionHandler(true)
    }
    updateData.backgroundColor = .systemBlue
    
    let configuration = UISwipeActionsConfiguration(actions: [deleteData, updateData])
    return configuration
  }
}

extension AllAddressViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let data = viewModel.allAddressData[indexPath.row]
    self.navigationController?.popViewController(animated: true)
    delegate?.setAddressDelivery(data: data)
  }
}
