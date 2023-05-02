//
//  MiCheMiCalTableViewCell.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit

class MiCheMiCalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
