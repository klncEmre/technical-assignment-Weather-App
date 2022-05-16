//
//  locationData.swift
//  weather_app
//
//  Created by EMRE KILINC on 15.05.2022.
//

import Foundation
struct locationData: Decodable{
    let title: String
    let location_type: String
    let latt_long: String
    let woeid: Int
    let distance: Int
    
}
