//
//  VerySpecialCell.swift
//  beast_list
//
//  Created by Ruslan Suvorov on 3/23/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

protocol VerySpecialCellDelegate: class{
    func setBeastedToTrue( indexPath: IndexPath )
}

class VerySpecialCell: UITableViewCell {
    
    weak var delegate: VerySpecialCellDelegate?
    
    @IBOutlet weak var beastLabel: UILabel!
    
    var indexPath: IndexPath!
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        delegate?.setBeastedToTrue( indexPath: indexPath )
    }
    

    
}
