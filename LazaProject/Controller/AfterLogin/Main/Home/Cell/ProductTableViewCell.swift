//
//  ProductTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 31/07/23.
//

import UIKit
import SDWebImage

protocol ProductTableViewCellDelegate: AnyObject {
  func productDidSelectItemAt(didSelectItemAt indexPath: IndexPath)
}

class ProductTableViewCell: UITableViewCell {
  
  private var dataProduct = WelcomeProduct()
  var viewModel = ViewModel()
  
  weak var delegate: ProductTableViewCellDelegate?
  
  @IBOutlet weak var productCollectionView: UICollectionView!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    productCollectionView.dataSource = self
    productCollectionView.delegate = self
    productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
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

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 300)
  }
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.productDidSelectItemAt(didSelectItemAt: indexPath)
  }
}
