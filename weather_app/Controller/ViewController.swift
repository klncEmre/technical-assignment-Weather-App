//
//  ViewController.swift
//  weather_app
//
//  Created by EMRE KILINC on 13.05.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
 
    let locationInfo = CLLocationManager() //to get GPS coordinates.
    var locationsHandler =  LocationsHandler()//to get data about the coordinates that we got earlier.
    
    var locationsForTable : [locationData]  = []
    @IBOutlet weak var locationsTable: UITableView!
    var customView = UIView()
    var infoLabel = UILabel(frame: CGRect(x: 0, y: 120, width: 200, height: 100))
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        locationInfo.delegate = self
        locationInfo.requestWhenInUseAuthorization()// to have permission to get gps data
        locationInfo.startUpdatingLocation() //EVERY TIME YOU CHANGE SIMULATOR LOCATION IT CHANGES LISTED LOCATION.
        
        
        locationsHandler.delegate = self
    
        locationsTable.dataSource = self
    
        locationsTable.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "mainPageCell")
       
        
        
        //BELOW IS TO CREATE LOADING SCREEN WHILE WAITING FOR GPS AND API RESPONSES.
        customView.frame = CGRect.init(x: 0, y: 0, width: 200, height: 200)
        customView.backgroundColor = UIColor.systemBackground   //give color to the view
        customView.center = self.view.center
        let newImgThumb = UIImageView(frame: CGRect(x: 0, y: 10, width: 200, height: 100))
        newImgThumb.contentMode = .scaleAspectFit
        newImgThumb.image = UIImage(systemName: "slowmo")
        customView.addSubview(newImgThumb)
        
        infoLabel.text = "Please wait until I get the location data.  "
        infoLabel.numberOfLines = 6
      
        customView.addSubview(infoLabel)
        
        self.view.addSubview(customView)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "nearby"){
            let vc = segue.destination as? NearbyCitiesViewController
            var cityOnly: [locationData] = []
            for loc in locationsForTable {
                if(loc.location_type == "City"){
                    cityOnly.append(loc)
                }
            }
            
            vc!.cities = cityOnly // I GET THE CITY LOCATIONS ONLY TO SHOW IN NEARBY CITIES PAGE
        }
    }
    
    @IBAction func NavigateNearbyCities(_ sender: Any) {
        if(!locationsForTable.isEmpty){
            performSegue(withIdentifier: "nearby", sender: self)
        }
        else{
            infoLabel.text =  "Loading... If it takes too much time, your simulator may not have GPS location. Please chack that from debug > simulate location, if you can not select any cities there please re-run app in this simulator and then select a locatin after that."
        }
        
    }
}

//MARK: - CLLocation Delegate
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            //Get location coordinates here
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            locationsHandler.fetchUrlData(latitude: lat, longitute: lon)
            }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.infoLabel.text = "Your simulator may not have GPS location. Please chack that from debug > simulate location, if you can not select any cities there please re-run app in this simulator."
    }
    
}

//MARK: - LocatinsHandlerDelegate
extension ViewController : LocationsHandlerDelegate{
    func didUpdateLocations(locationsHandler: LocationsHandler, locationsUpdated: [locationData]) {
        DispatchQueue.main.async {
            self.locationsForTable = locationsUpdated
            self.locationsTable.reloadData()
            self.customView.removeFromSuperview()
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

// MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainPageCell", for: indexPath) as! LocationCell
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.9)
        }
        else{
            cell.backgroundColor = UIColor.systemBlue
        }
        cell.title.text = locationsForTable[indexPath.row].title
        cell.type.text = "Type:  \(locationsForTable[indexPath.row].location_type)"
        cell.distance.text = "Distance:  \(locationsForTable[indexPath.row].distance) meters"
        
        return cell
    }
    
    
}
