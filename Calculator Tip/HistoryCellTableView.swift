//
//  HistoryCellTableView.swift
//  Calculator Tip
//
//  Created by MrDummy on 5/31/17.
//  Copyright © 2017 Nhom5. All rights reserved.
//

import UIKit

class HistoryCellTableView: UITableViewCell {
    
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var lblTipAmount: UILabel!
    @IBOutlet weak var lblThanhTien: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
