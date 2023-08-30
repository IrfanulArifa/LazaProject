//
//  AllAddressViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 09/08/23.
//

import UIKit

protocol backToCartfromAddressDelegate: AnyObject{
  func backToCartFromAddress()
}

class AllAddressViewController: UIViewController {
  
  weak var delegate: backToCartfromAddressDelegate?
  let viewModel = AddressViewModel()
  
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
    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
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
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
    delegate?.backToCartFromAddress()
  }
  
  @IBAction func addNewAddressClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "AddressViewController", bundle: nil).instantiateViewController(withIdentifier: "AddressViewController")
    storyboard.modalPresentationStyle = .fullScreen
    self.present(storyboard, animated: true)
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
  
//  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//  }
}

extension AllAddressViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

