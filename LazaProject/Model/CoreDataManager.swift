//
//  CoreDataManager.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 06/09/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
  var presentAlertSucces: (() -> Void)?
  var presentAlertFailed: (() -> Void)?
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  func create(_ cardModel: CardModel) {
    guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataCard")
    fetchRequest.predicate = NSPredicate(format: "number = %@", cardModel.number)
    
    do {
      let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
      
      if result?.isEmpty == true {
        // Data tidak ditemukan, tambahkan ke Core Data
        let userEntity = NSEntityDescription.entity(forEntityName: "DataCard", in: managedContext)
        
        //entity body
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(cardModel.userId, forKey: "userId")
        insert.setValue(cardModel.cvv, forKey: "cvv")
        insert.setValue(cardModel.expMonth, forKey: "expMonth")
        insert.setValue(cardModel.expYear, forKey: "expYear")
        insert.setValue(cardModel.number, forKey: "number")
        insert.setValue(cardModel.owner, forKey: "owner")
        
        try managedContext.save()
        print("Saved data into CoreData")
        presentAlertSucces?()
      } else {
        presentAlertFailed?()
      }
    } catch let error {
      print("Failed to create data", error)
    }
  }
  
  func retrieve(completion: @escaping ([CardModel]) -> Void) {
    var creditCard = [CardModel]() // Mulai dengan array kosong
    
    let managedContext = appDelegate?.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataCard")
    
    do {
      let result = try managedContext?.fetch(fetchRequest)
      result?.forEach { creditCardData in
        let card = CardModel(
          owner: creditCardData.value(forKey: "owner") as! String,
          number: creditCardData.value(forKey: "number") as! String,
          cvv: creditCardData.value(forKey: "cvv") as! String,
          expMonth: creditCardData.value(forKey: "expMonth") as! String,
          expYear: creditCardData.value(forKey: "expYear") as! String,
          userId: creditCardData.value(forKey: "userId") as! Int
        )
        creditCard.append(card)
      }
      
      completion(creditCard) // Mengirimkan data yang ditemukan
      print("Success")
    } catch let error {
      print("Failed to fetch data", error)
    }
  }
  
  
  
  func updateData(_ cardModel: CardModel, numberCard: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "DataCard")
    fetchRequest.predicate = NSPredicate(format: "number = %@", numberCard)
    
    do {
      let fetchedResults = try managedContext.fetch(fetchRequest)
      
      if let updateCard = fetchedResults.first {
        updateCard.setValue(cardModel.number, forKey: "number")
        updateCard.setValue(cardModel.owner, forKey: "owner")
        updateCard.setValue(cardModel.expMonth, forKey: "expMonth")
        updateCard.setValue(cardModel.expYear, forKey: "expYear")
        updateCard.setValue(cardModel.cvv, forKey: "cvv")
      }
      
      do {
        try managedContext.save()
        presentAlertSucces?()
        print("Data updated successfully")
      } catch{
        presentAlertFailed?()
        print("Failed to update data: (error), (error.userInfo)", error)
      }
      
    } catch {
      print("Fetch error: (error), (error.userInfo)", error)
    }
  }
  
  func delete(_ creditCard: CardModel, completion: @escaping () -> Void) {
    guard let managedContext = appDelegate?.persistentContainer.viewContext else {
      return }
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DataCard")
    fetchRequest.predicate = NSPredicate(format: "number = %@", creditCard.number)
    
    do {
      let result = try managedContext.fetch(fetchRequest)
      
      for dataToDelete in result {
        managedContext.delete(dataToDelete as! NSManagedObject)
      }
      try managedContext.save()
      completion()
      
    } catch let error {
      print("Unable to delete data", error)
    }
  }
}
