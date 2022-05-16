//
//  CityClickableCell.swift
//  weather_app
//
//  Created by EMRE KILINC on 16.05.2022.
//

import UIKit

class CityClickableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
