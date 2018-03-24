//
//  BeastModel.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit
import CoreData


class BeastModel {
    
    private var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    private var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )
    
    static let shared = BeastModel()
    
    
    func getAll( whereIsBeastedIs beastedState: Bool ) -> [Beast] {
        
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Beast" )
        
        request.predicate = NSPredicate( format: "isBeasted = %@", beastedState as CVarArg )
        do {
            return try managedObjectContext.fetch( request ) as! [Beast]
        } catch {
            print( error )
            return []
        }
    }
    
    func create(item text: String) -> Beast {
        let item = NSEntityDescription.insertNewObject( forEntityName: "Beast", into: managedObjectContext ) as! Beast
        item.desc = text
        item.isBeasted = false
        saveContext()
        return item
    }
    
    func delete(_ item: Beast) {
        managedObjectContext.delete(item)
        saveContext()
    }
    
    func saveContext() {
        appDelegate.saveContext()
    }
}
