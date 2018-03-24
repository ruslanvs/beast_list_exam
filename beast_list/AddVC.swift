//
//  AddVC.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit


protocol AddVCDelegate: class {
    func itemSaved(with text: String, at indexPath: IndexPath?)
    func cancelButtonPressed (by controller: AddVC)
}

class AddVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var itemDescInputField: UITextField!
    
    var child = ChildOfAddVC()

    
    weak var delegate: AddVCDelegate?
    
    var item: String?
    var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDescInputField.isHidden = true // PREVIOUSLY IMPLEMENTED SOLUTION. DID NOT WANT TO THROUGH THE CODE AWAY
        itemDescInputField.text = item
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
//        let text = itemDescInputField.text!
        let text = child.itemDescInputFieldInTV.text!
        delegate?.itemSaved(with: text, at: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        child = segue.destination as! ChildOfAddVC
        child.item = item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
