//
//  BeastedListTVC.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit
import CoreData

class BeastedListTVC: UITableViewController {

    var result = [Beast]()
    
    var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchAll()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAll()
        tableView.reloadData()
    }
    
    func fetchAll(){
        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Beast" )
        do {
            result = try managedObjectContext.fetch( request ) as! [Beast]
        } catch {
            print( error )
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "beastedCell", for: indexPath)
            
            if let data = result[indexPath.row].desc {
                cell.textLabel?.text = data
            }
            
            if let data = result[indexPath.row].beastedDate {
                let d = DateFormatter()
                d.dateFormat = "EEE, MMM d"
                cell.detailTextLabel?.text = d.string( from: data )
            }
            
            if result[indexPath.row].isBeasted == false {
                cell.isHidden = true
            }
            
            return cell
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        cellHeight = 100.0
        if result[indexPath.row].isBeasted == false {
            cellHeight = 0.0
        }
        
        return cellHeight
    }
}
