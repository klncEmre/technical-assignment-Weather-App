//
//  WeatherCell.swift
//  weather_app
//
//  Created by EMRE KILINC on 16.05.2022.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
