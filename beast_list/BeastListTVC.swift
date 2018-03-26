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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
    }
    
    override func viewWillAppear(_ animated: Bool ) {
        super.viewWillAppear( animated )
        result = BeastModel.shared.getAll( whereIsBeastedIs: false )
        tableView.reloadData()
    }

    @IBAction func seedButtonPressed(_ sender: UIBarButtonItem) {
        print( "seed button pressed" )
        let beastsArr = ["Laundry", "Swim", "fly", "Groceries", "Laugh", "Jump"]
        for desc in beastsArr {
            BeastModel.shared.create(item: desc)
        }
        result = BeastModel.shared.getAll( whereIsBeastedIs: false )
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let addVC = navigationController.topViewController as! AddVC
        addVC.delegate = self

        if (sender as? IndexPath) != nil {
            let indexPath = sender as! IndexPath
            let item = result[indexPath.row]
            addVC.item = item.desc!
            addVC.indexPath = indexPath
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        BeastModel.shared.delete( result[indexPath.row] )
        result.remove( at: indexPath.row )
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verySpecialCell", for: indexPath) as! VerySpecialCell
        
        if let data = result[indexPath.row].desc {
            cell.beastLabel.text = data
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue( withIdentifier: "AddSegue", sender: indexPath )
    }
}

extension BeastListTVC: AddVCDelegate {
    func itemSaved(with text: String, at indexPath: IndexPath? ){
        
        if let i = indexPath {
            result[i.row].desc = text
            BeastModel.shared.saveContext()
        } else {
            let item = BeastModel.shared.create(item: text)
            result.append( item )
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(by: AddVC) {
        dismiss(animated: true, completion: nil)
    }
}

extension BeastListTVC: VerySpecialCellDelegate {
    func setBeastedToTrue( indexPath: IndexPath ) {
        let beastedItem = result[indexPath.row]
        beastedItem.isBeasted = true
        beastedItem.beastedDate = Date()
        BeastModel.shared.saveContext()
        result.remove(at: indexPath.row)
//        result = BeastModel.shared.getAll( whereIsBeastedIs: false )
        tableView.deleteRows(at: [indexPath], with: .automatic) //>> Eli: App often (but not always) crushes when "beasting" with animation. Perhaps some async callback is needed?
//        tableView.reloadData()
    }
}
