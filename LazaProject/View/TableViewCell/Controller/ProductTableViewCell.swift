//
//  ProductTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 31/07/23.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
  
  private var dataProduct = WelcomeProduct()
  var viewModel = ViewModel()
  
  @IBOutlet weak var productCollectionView: UICollectionView!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    productCollectionView.dataSource = self
    productCollectionView.delegate = self
    productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configuring(_ array: WelcomeProduct){
    dataProduct = array
    productCollectionView.reloadData()
  }
  
}

extension ProductTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataProduct.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let dataCell = dataProduct[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    let image = dataCell.image
    cell.productImage.sd_setImage(with: URL(string:image))
    cell.productName.text = dataCell.title
    cell.productPrice.text = "$" + String(dataCell.price)
    return cell
  }
  
  
}

extension ProductTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: viewModel.welcomeElement[indexPath.item])
    vc.navigationController?.pushViewController(vc, animated: true)
  }
}

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 300)
  }
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
