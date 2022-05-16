//
//  NearbyCitiesViewController.swift
//  weather_app
//
//  Created by EMRE KILINC on 15.05.2022.
//

import UIKit

class NearbyCitiesViewController: UIViewController {
    var text: String = ""
    var cities : [locationData] = []
    var selectedCityData : locationData?
    @IBOutlet weak var citiesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTable.dataSource = self
        citiesTable.delegate = self
        citiesTable.register(UINib(nibName: "CityClickableCell", bundle: nil), forCellReuseIdentifier: "clickableCity")
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //WHEN I GO TO DETAIL PAGE, I NEED TO HAVE THE DATA ABOUT THE CITY THAT I AM NAVIGATING TO.
        if(segue.identifier == "details"){
            let vc = segue.destination as? DetailsViewController
            vc?.data = selectedCityData
        }
    }
  

}

extension NearbyCitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clickableCity" , for: indexPath) as! CityClickableCell
        cell.name.text = cities[indexPath.row].title
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCityData = cities[indexPath.row] // UPDATED THE SELECTED CITY AS USER SELECT NEW CITY
        performSegue(withIdentifier: "details", sender: self)
    }
    
}
