//
//  SelectedBrandViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 28/08/23.
//

import UIKit
import SDWebImage

class SelectedBrandViewController: UIViewController {
  
  @IBOutlet weak var brandImage: UIImageView!
  @IBOutlet weak var sortingButton: UIButton!{
    didSet {
      sortingButton.setImage(UIImage(systemName: ""), for: .normal)
    }
  }
  
  @IBOutlet weak var totalItems: UILabel!{
    didSet {
      totalItems.font = UIFont(name: "Poppins-Regular", size: 17)
    }
  }
  
  @IBOutlet weak var SelectedCollection: UICollectionView!
  
  var productBrand: String?
  var productLogo: String?
  var arrayProduct = [Datum]()
  let viewModel = HomeViewModel()
  
  func configureBrand(name: String, imageLogo: String){
    productBrand = name
    productLogo = imageLogo
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    
    SelectedCollection.dataSource = self
    SelectedCollection.delegate = self
    SelectedCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    
    viewModel.reloadTable = {
      DispatchQueue.main.async {
        self.SelectedCollection.reloadData()
        self.arrayProduct = self.viewModel.productByName
        self.totalItems.text = String(self.arrayProduct.count) + " Items"
        if self.productLogo == "" {
          self.brandImage.removeFromSuperview()
        } else {
          let imageURL = URL(string: self.productLogo!)
          self.brandImage.sd_setImage(with: imageURL)
        }
      }
    }
    
    viewModel.loadData(productBrand!)
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func sortingButton(_ sender: UIButton) {
    sortData()
  }
  
  func sortData(){
    if sortingButton.currentImage == UIImage(systemName: ""){
      let newArray = viewModel.productByName.sorted { $0.name < $1.name }
      arrayProduct = newArray
      SelectedCollection.reloadData()
      sortingButton.setImage(UIImage(systemName: "text.line.first.and.arrowtriangle.forward"), for: .normal)
      sortingButton.setTitle("A-Z", for: .normal)
    } else if sortingButton.currentImage == UIImage(systemName: "text.line.first.and.arrowtriangle.forward") {
      let newArray = arrayProduct.sorted { $0.name > $1.name }
      arrayProduct = newArray
      SelectedCollection.reloadData()
      sortingButton.setImage(UIImage(systemName: "text.line.last.and.arrowtriangle.forward"), for: .normal)
      sortingButton.setTitle("Z-A", for: .normal)
    } else if sortingButton.currentImage == UIImage(systemName: "text.line.last.and.arrowtriangle.forward") {
      let newArray = arrayProduct.sorted { $0.name < $1.name }
      arrayProduct = newArray
      SelectedCollection.reloadData()
      sortingButton.setImage(UIImage(systemName: "text.line.first.and.arrowtriangle.forward"), for: .normal)
      sortingButton.setTitle("A-Z", for: .normal)
    }
  }
  
}

extension SelectedBrandViewController: UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: viewModel.productByName[indexPath.item].id)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension SelectedBrandViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayProduct.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = arrayProduct[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    let imageURL = URL(string: data.imageURL)
    cell.productImage.sd_setImage(with: imageURL)
    cell.productName.text = data.name.capitalized
    cell.productPrice.text = "Rp. " + String(data.price).capitalized
    return cell
  }
}

extension SelectedBrandViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
}

