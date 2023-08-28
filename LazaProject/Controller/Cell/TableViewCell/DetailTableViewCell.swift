//
//  DetailTableViewCell.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 02/08/23.
//

import UIKit

protocol ReviewTableViewCellDelegate: AnyObject {
  func actionClicked()
  func sizeClicked(_ collectionView: UICollectionView, _ didSelectItemAt: IndexPath)
}

class DetailTableViewCell: UITableViewCell {
  
  let viewModel = ViewModel()
  
  weak var delegate: ReviewTableViewCellDelegate?
  
  @IBOutlet weak var imageDetail: UIImageView!
  @IBOutlet weak var categoryDetailLabel: UILabel!
  @IBOutlet weak var productNameDetailLabel: UILabel!
  @IBOutlet weak var priceDetailLabel: UILabel!
  @IBOutlet weak var descriptionDetail: UILabel!
  @IBOutlet weak var sizeCollection: UICollectionView!
  
  private(set) var productSize: [Sizes]? {
    didSet {
      sizeCollection.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print("Awake")
    sizeCollection.dataSource = self
    sizeCollection.delegate = self
    sizeCollection.register(UINib(nibName: "SizeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SizeCollectionViewCell")
    
    viewModel.reloadSize = {
      DispatchQueue.main.async {
        self.sizeCollection.reloadData()
      }
    }
  }
  
  func configureSize(sizes: [Sizes]) {
    productSize = sizes
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func viewAllButtonClicked(_ sender: UIButton) {
    delegate?.actionClicked()
  }
}

extension DetailTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return productSize?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let data = productSize?[indexPath.item] else { return UICollectionViewCell() }
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCollectionViewCell", for: indexPath) as? SizeCollectionViewCell else { return UICollectionViewCell() }
    cell.sizeLabel.text = data.size.capitalized
    if let size = productSize?[indexPath.item] {
      cell.configure(sizeId: size.id, sizeText: size.size)
    }
    return cell
  }
  
  
}

extension DetailTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.sizeClicked(collectionView, indexPath)
  }
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 60)
  }
}
