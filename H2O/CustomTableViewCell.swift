//
//  CustomTableViewCell.swift
//  H2O
//
//  Created by Scott Simon on 4/19/18.
//  Copyright © 2018 neiu.edu. All rights reserved.
//

import UIKit

//datasource for what is displayed
class CustomTableViewCell: UITableViewCell {
    
    // table cell, thumbnail, and name of planet
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
}


