//
//  ViewcontrollerTableViewCell.swift
//  Banco
//
//  Created by Joel Palomares Jasso on 4/21/19.
//  Copyright © 2019 Joel Palomares Jasso. All rights reserved.
//

import UIKit

class ViewcontrollerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblMoney: UILabel!
    
    @IBOutlet weak var lblManager: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
