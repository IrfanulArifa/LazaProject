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
  func viewAllProduct()
}

class ProductTableViewCell: UITableViewCell {
  
  var dataProduct = [Datum]()
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
  
  func configuring(_ array: [Datum]){
    dataProduct = array
    productCollectionView.reloadData()
  }
  
  @IBAction func viewAllProduct(_ sender: UIButton) {
    delegate?.viewAllProduct()
  }
  
}

extension ProductTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let dataCell = dataProduct[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    let image = dataCell.imageURL
    cell.productImage.sd_setImage(with: URL(string:image))
    cell.productName.text = dataCell.name
    cell.productPrice.text = "Rp. " + String(dataCell.price)
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
