//
//  BeastListVC.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

//import UIKit
//import CoreData
//
//class BeastListVC: UIViewController {
//
//    var result = [Beast]()
//
//    var managedObjectContext = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
//    var appDelegate = ( UIApplication.shared.delegate as! AppDelegate )
//
//
//    @IBOutlet weak var tableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
////        seedData()
//        fetchAll()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func seedData(){
//        let beastsArr = ["Laundry", "Swim", "fly", "Groceries"]
//        for b in beastsArr {
//            let item = NSEntityDescription.insertNewObject(forEntityName: "Beast", into: managedObjectContext) as! Beast
//            item.desc = b
//            appDelegate.saveContext()
//        }
//        fetchAll()
//    }
//
//    func fetchAll(){
//        let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Beast" )
//        do {
//            result = try managedObjectContext.fetch( request ) as! [Beast]
//        } catch {
//            print( error )
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (sender as? UIBarButtonItem) != nil {
//            let navigationController = segue.destination as! UINavigationController
//            let addVC = navigationController.topViewController as! AddVC
//            addVC.delegate = self
//        } else if (sender as? NSIndexPath) != nil {
//            let navigationController = segue.destination as! UINavigationController
//            let addVC = navigationController.topViewController as! AddVC
//            addVC.delegate = self
//
//            let indexPath = sender as! NSIndexPath
//            let item = result[indexPath.row]
//            addVC.item = item.desc!
//            addVC.indexPath = indexPath
//        }
//    }
//}
//
//extension BeastListVC: UITableViewDataSource {
//
//
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        let item = result[indexPath.row]
//        managedObjectContext.delete(item)
//        appDelegate.saveContext()
//
//        result.remove(at: indexPath.row)
//        tableView.reloadData()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return result.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "beastCell", for: indexPath)
//
//        if let data = result[indexPath.row].desc {
//            cell.textLabel?.text = data
//        }
//
//        return cell
//    }
//}
//
//protocol AddVCDelegate: class {
//    func itemSaved(by controller: AddVC, with text: String, at indexPath: NSIndexPath?)
//    func cancelButtonPressed (by controller: AddVC)
//}
//
//extension BeastListVC: AddVCDelegate {
//    func itemSaved(by controller: AddVC, with text: String, at indexPath: NSIndexPath? ){
//        if let i = indexPath {
//            result[i.row].desc = text
//
//        } else {
//            let item = NSEntityDescription.insertNewObject( forEntityName: "Beast", into: managedObjectContext ) as! Beast
//            item.desc = text
//            result.append( item )
//        }
//
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print (error)
//        }
//
//        tableView.reloadData()
//        dismiss(animated: true, completion: nil)
//    }
//
//    func cancelButtonPressed(by controller: AddVC) {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension BeastListVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected")
//        performSegue( withIdentifier: "AddSegue", sender: indexPath )
//
//    }
//}

