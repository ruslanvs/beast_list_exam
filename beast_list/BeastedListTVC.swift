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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        result = BeastModel.shared.getAll( whereIsBeastedIs: true )
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        BeastModel.shared.delete( result[indexPath.row] )
        result.remove( at: indexPath.row )
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "beastedCell", for: indexPath )
        
        if let data = result[indexPath.row].desc {
            cell.textLabel?.text = data
        }
        
        if let data = result[indexPath.row].beastedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, MMM d"
            cell.detailTextLabel?.text = dateFormatter.string( from: data )
        }
        
        return cell
    }

}
