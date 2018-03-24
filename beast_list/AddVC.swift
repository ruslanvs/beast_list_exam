//
//  AddVC.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
    
    @IBOutlet weak var itemDescInputField: UITextField!
    
    weak var delegate: AddVCDelegate?
    var item: String?
    var indexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDescInputField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemDescInputField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
}