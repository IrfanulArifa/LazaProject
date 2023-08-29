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
  let viewModel = ViewModel()
  
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
    
    viewModel.reloadUser = {
      DispatchQueue.main.async {
        self.addressTableView.reloadData()
      }
    }
    
    viewModel.loadDataUser()
    
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
    return viewModel.userData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = viewModel.userData[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllAddressTableViewCell") as? AllAddressTableViewCell else { return UITableViewCell() }
    cell.nameAddress.text = data.name.firstname.capitalized + " " + data.name.lastname.capitalized
    cell.cityAddress.text = data.address.city.capitalized
    cell.numberAddress.text = String(data.address.number)
    cell.streetAddress.text = data.address.street.capitalized
    cell.zipcode.text = data.address.zipcode
    return cell
  }
  
  
}

extension AllAddressViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
