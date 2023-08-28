//
//  AllProductViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 24/08/23.
//

import UIKit
import SDWebImage

class AllProductViewController: UIViewController {
  
  var newData : [Datum] = []
  
  @IBOutlet weak var allProductTitle: UILabel!{
    didSet { allProductTitle.font = UIFont(name: "Poppins-Regular", size: 28)}
  }
  @IBOutlet weak var itemsCount: UILabel!
  @IBOutlet weak var sortButton: UIButton!{
    didSet { sortButton.setImage(UIImage(systemName: ""), for: .normal)}
  }
  
  @IBOutlet weak var productCollection: UICollectionView!
  
  func configureData(data: [Datum]){
    newData = data
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    productCollection.dataSource = self
    productCollection.delegate = self
    productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    itemsCount.text = String(newData.count) + " Items"
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  @IBAction func sortButtonClicked(_ sender: UIButton) {
    
    if sortButton.currentImage == UIImage(systemName: ""){
      let newArray = newData.sorted { $0.name < $1.name }
      newData = newArray
      productCollection.reloadData()
      sortButton.setImage(UIImage(systemName: "text.line.first.and.arrowtriangle.forward"), for: .normal)
    } else if sortButton.currentImage == UIImage(systemName: "text.line.first.and.arrowtriangle.forward") {
      let newArray = newData.sorted { $0.name > $1.name }
      newData = newArray
      productCollection.reloadData()
      sortButton.setImage(UIImage(systemName: "text.line.last.and.arrowtriangle.forward"), for: .normal)
    } else if sortButton.currentImage == UIImage(systemName: "text.line.last.and.arrowtriangle.forward") {
      let newArray = newData.sorted { $0.name < $1.name }
      newData = newArray
      productCollection.reloadData()
      sortButton.setImage(UIImage(systemName: "text.line.first.and.arrowtriangle.forward"), for: .normal)
    }
  }
  
}

extension AllProductViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: newData[indexPath.item].id)
    vc.modalPresentationStyle = .fullScreen
    
    self.present(vc, animated: true)
  }
}

extension AllProductViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return newData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let dataCell = newData[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    let imageURL = URL(string: dataCell.imageURL)
    cell.productImage.sd_setImage(with: imageURL)
    cell.productName.text = dataCell.name.capitalized
    cell.productPrice.text = "Rp. " + String(dataCell.price)
    return cell
  }
  
}

extension AllProductViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
