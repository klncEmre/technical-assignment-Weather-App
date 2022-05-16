import Foundation
import Alamofire

protocol weatherDelegate{
    func didUpdateWeather(weatherHandler:WeatherHandler,weatherUpdated: weatherData)
    func didFailWithError(error:Error)
       
}

//Struct to handle all weather data - api connections
struct WeatherHandler {
    var delegate:weatherDelegate?
    var woeid : Int = 44418
  
    func getData(){
        let url: String = "https://www.metaweather.com/api/location/\(woeid)/"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        
        //to get status code
                        if let status = response.response?.statusCode {
                            switch(status){
                            case 201:
                                print("example success")
                            default:
                                print("error with response status: \(status)")
                            }
                        }
        //to get JSON return value
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary

                        let weathers = JSON["consolidated_weather"] as! Array<Any>
                        var weatherObject = weatherData(city:JSON["title"] as! String , daysData:[])
                        for wd in weathers{
                            let weather = wd as! [String:Any]
                            let date = weather["applicable_date"] as! String
                            let state = weather["weather_state_name"] as! String
                            let abr = weather["weather_state_abbr"] as! String
                            weatherObject.daysData.append(dayData(date: date, state: state, weather_state_abbr: abr))
                            
                        }
                        delegate?.didUpdateWeather(weatherHandler: self, weatherUpdated: weatherObject)
                        
                    }

                }
    }
    
}

