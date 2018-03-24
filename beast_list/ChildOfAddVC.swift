//
//  ChildOfAddVC.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/24/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class ChildOfAddVC: UITableViewController {
    //>> Eli: review the impementation of embedded static tvc
    
    @IBOutlet weak var itemDescInputFieldInTV: UITextField!

    var item: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemDescInputFieldInTV.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
