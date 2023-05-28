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
    @IBOutlet var rectangle: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(amount: Int, note: String, type: Int) {
        amountLabel.text = String(amount) + "円"
        noteLabel.text = note
        if (type == 0) {
            rectangle.backgroundColor = UIColor.systemRed
        } else if (type == 1) {
            rectangle.backgroundColor = UIColor.systemGreen
        }
        
        
    }
    
}
