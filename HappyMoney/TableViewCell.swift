//
//  TableViewCell.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
