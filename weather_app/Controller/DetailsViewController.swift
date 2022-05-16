//
//  DetailsViewController.swift
//  weather_app
//
//  Created by EMRE KILINC on 15.05.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    
    var data:locationData?
    var weatherHandler = WeatherHandler()
    var weathers : [dayData] = []
    
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var tableWeather: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherHandler.delegate = self
        weatherHandler.woeid = data?.woeid ?? 44418
        weatherHandler.getData()
        tableWeather.dataSource = self
        tableWeather.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "weather")
        detailText.text = "Weather Data for \(data!.title)"
        // Do any additional setup after loading the view.
    }
    

}

//MARK: - WEATHER DELEGATE
extension DetailsViewController : weatherDelegate{
    func didUpdateWeather(weatherHandler: WeatherHandler, weatherUpdated: weatherData) {
        DispatchQueue.main.async {
            self.weathers = weatherUpdated.daysData
            self.tableWeather.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
//MARK: - TABLEVIEW DATA SOURCE EXTENSION
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather", for: indexPath) as! WeatherCell
        cell.date.text =  weathers[indexPath.row].date
        cell.state.text = weathers[indexPath.row].state
        let abbreviation = weathers[indexPath.row].weather_state_abbr
        let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(abbreviation).png")!
        DispatchQueue.global().async {
               // Fetch Image Data
               if let data = try? Data(contentsOf: url) {
                   DispatchQueue.main.async {
                       // Create Image and Update Image View
                       cell.logo!.image = UIImage(data: data)
                   }
               }
           }

        return cell
    }
    
    
}

