//
//  VerySpecialCell.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import Foundation
import UIKit

protocol VerySpecialCellDelegate: class{
    func setBeastedToTrue( index: Int )
}

class VerySpecialCell: UITableViewCell {
    
    weak var delegate: VerySpecialCellDelegate?
    
    @IBOutlet weak var beastButton: UIButton!
    @IBOutlet weak var beastLabel: UILabel!
    
    var index = Int()
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        delegate?.setBeastedToTrue( index: index )
    }
    

    
}
