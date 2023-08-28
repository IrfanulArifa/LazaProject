//
//  AllCategoryViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 24/08/23.
//

import UIKit
import SDWebImage

class AllCategoryViewController: UIViewController {

  @IBOutlet weak var allCategory: UILabel!{
    didSet { allCategory.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var totalItems: UILabel!{
    didSet { totalItems.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  @IBOutlet weak var sortButton: UIButton!{
    didSet {
      sortButton.setImage(UIImage(systemName: ""), for: .normal)
    }
  }
  @IBOutlet weak var allCategoryCollection: UICollectionView!
  
  var categoryData: [Description] = []
  
  func configureCategory(data: [Description]){
    categoryData = data
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    allCategoryCollection.dataSource = self
    allCategoryCollection.delegate = self
    allCategoryCollection.register(UINib(nibName: "AllCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllCategoryCollectionViewCell")
    totalItems.text = String(categoryData.count) + " Items"
  }
  
  
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  @IBAction func sortButtonClicked(_ sender: UIButton) {
    sortData()
  }
  
  func sortData(){
    if sortButton.currentImage == UIImage(systemName: ""){
      let newArray = categoryData.sorted { $0.name < $1.name }
      categoryData = newArray
      allCategoryCollection.reloadData()
      sortButton.setImage(UIImage(systemName: "text.line.first.and.arrowtriangle.forward"), for: .normal)
    } else if sortButton.currentImage == UIImage(systemName: "text.line.first.and.arrowtriangle.forward") {
      let newArray = categoryData.sorted { $0.name > $1.name }
      categoryData = newArray
      allCategoryCollection.reloadData()
      sortButton.setImage(UIImage(systemName: "text.line.last.and.arrowtriangle.forward"), for: .normal)
    } else if sortButton.currentImage == UIImage(systemName: "text.line.last.and.arrowtriangle.forward") {
      let newArray = categoryData.sorted { $0.name < $1.name }
      categoryData = newArray
      allCategoryCollection.reloadData()
      sortButton.setImage(UIImage(systemName: "text.line.first.and.arrowtriangle.forward"), for: .normal)
    }
  }
}

extension AllCategoryViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "SelectedBrandViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(identifier: "SelectedBrandViewController") as? SelectedBrandViewController else { return }
    vc.configureBrand(name: categoryData[indexPath.item].name, imageLogo: categoryData[indexPath.item].logoURL)
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
}

extension AllCategoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let dataCell = categoryData[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCategoryCollectionViewCell", for: indexPath) as? AllCategoryCollectionViewCell else { return UICollectionViewCell() }
    let imageURL = URL(string: dataCell.logoURL)
    cell.imageBrand.sd_setImage(with: imageURL)
    cell.labelBrand.text = dataCell.name
    return cell
  }
}

extension AllCategoryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
