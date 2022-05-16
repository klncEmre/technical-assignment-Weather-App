//
//  weatherData.swift
//  weather_app
//
//  Created by EMRE KILINC on 16.05.2022.
//

import Foundation

struct weatherData {
    var city: String
    var daysData: [dayData]
    
        
    
    
}
struct dayData {
    var date: String
    var state: String
    var weather_state_abbr: String
    
}
