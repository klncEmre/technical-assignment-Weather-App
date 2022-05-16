
//  weather_app
//
//  Created by EMRE KILINC on 15.05.2022.
//

import Foundation
import CoreLocation

protocol LocationsHandlerDelegate {
    func didUpdateLocations(locationsHandler: LocationsHandler, locationsUpdated : [locationData])
    func didFailWithError(error: Error)
}


//Struct to handle all location data and api connections
struct LocationsHandler {
    
    var delegate: LocationsHandlerDelegate?
    let urlAPI = "https://www.metaweather.com/api/location/search/"
    func fetchUrlData(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(urlAPI)?lattlong=\(latitude),\(longitute)"
        getAllData(with: urlString)
    }
    
    func getAllData(with urlString: String) {
    
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let decodedData = self.parseJsonData(safeData) {
                        self.delegate?.didUpdateLocations(locationsHandler: self, locationsUpdated:decodedData)
                    }
                }
            }
            task.resume()
        }
       
    }



    func parseJsonData(_ itemDataToUse: Data) -> [locationData]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([locationData].self, from: itemDataToUse)
            
            return decodedData
            
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }



    
}
