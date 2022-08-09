//
//  MyProjectTableViewCell.swift
//  myProject
//
//  Created by Prasanna on 11/08/21.
//  Copyright © 2021 sakthipriya. All rights reserved.
//

import UIKit

class MyProjectTableViewCell: UITableViewCell {
   
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var dobLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
