//
//  HistoryCell.swift
//  Swift Test
//
//  Created by Anders Berntsen on 10/08/2020.
//  Copyright © 2020 Anders Berntsen. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var searchText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
