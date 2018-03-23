//
//  BeastListTVC.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit
import CoreData

class BeastListTVC: UITableViewController {
    
    var result = [Beast]()
    
    var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //        seedData()
        fetchAll()
    }
    
    func seedData(){
        let beastsArr = ["Laundry", "Swim", "fly", "Groceries"]
        for b in beastsArr {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Beast", into: managedObjectContext) as! Beast
            item.desc = b
            appDelegate.saveContext()
        }
        fetchAll()
    }
    
    func fetchAll(){
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Beast" )
        do {
            result = try managedObjectContext.fetch( request ) as! [Beast]
        } catch {
            print( error )
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIBarButtonItem) != nil {
            let navigationController = segue.destination as! UINavigationController
            let addVC = navigationController.topViewController as! AddVC
            addVC.delegate = self
        } else if (sender as? NSIndexPath) != nil {
            let navigationController = segue.destination as! UINavigationController
            let addVC = navigationController.topViewController as! AddVC
            addVC.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = result[indexPath.row]
            addVC.item = item.desc!
            addVC.indexPath = indexPath
            print( item, indexPath )
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = result[indexPath.row]
        managedObjectContext.delete(item)
        appDelegate.saveContext()
        
        result.remove(at: indexPath.row)
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verySpecialCell", for: indexPath)
        
        if let data = result[indexPath.row].desc {
            cell.textLabel?.text = data
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        performSegue( withIdentifier: "AddSegue", sender: indexPath )
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol AddVCDelegate: class {
    func itemSaved(by controller: AddVC, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed (by controller: AddVC)
}

extension BeastListTVC: AddVCDelegate {
    func itemSaved(by controller: AddVC, with text: String, at indexPath: NSIndexPath? ){
        if let i = indexPath {
            result[i.row].desc = text
            
        } else {
            let item = NSEntityDescription.insertNewObject( forEntityName: "Beast", into: managedObjectContext ) as! Beast
            item.desc = text
            result.append( item )
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print (error)
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(by controller: AddVC) {
        dismiss(animated: true, completion: nil)
    }
}

