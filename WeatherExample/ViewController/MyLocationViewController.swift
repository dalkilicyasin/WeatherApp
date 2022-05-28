//
//  MyLocationViewController.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 28.05.2022.
//

import UIKit
import CoreLocation

class MyLocationViewController : UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelMAxTemp: UILabel!
    @IBOutlet weak var labelMinTemp: UILabel!
    @IBOutlet weak var labelDayly: UILabel!
    @IBOutlet weak var labelNight: UILabel!
    var cityName = ""
    var cityKey =  ""
    var lat = ""
    var long = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
        
        let geoPositionRequestModel = SearchLocationRequestModel.init(searchText: "\(self.lat),\(self.long)")
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .GeaPosition, method: .get, parameters: geoPositionRequestModel.requestPathString()) { (response : CityListResponseModel ) in
            
            if response.type != nil {
                self.cityName = response.localizedName ?? ""
                self.cityKey = response.Key ?? ""
                
                self.labelCityName.text = "\(self.cityName) Weather Detail"
                
                let foreCastRequestModel = ForeCastRequestModel.init(cityCode: self.cityKey)
                NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .ForeCast, method: .get, parameters: foreCastRequestModel.requestPathString()) { (response : ForeCastResponseModel ) in
                    
                    if response.DailyForecasts != nil {
                        
                        self.labelMAxTemp.text = "High Tempature : \(response.DailyForecasts?[0].temperature?.maximum?.value ?? 0.0)F"
                        self.labelMinTemp.text = "Lowest Tempature : \(response.DailyForecasts?[0].temperature?.minimum?.value ?? 0.0)F"
                        self.labelDayly.text = "Dayly : \(response.DailyForecasts?[0].day?.iconPhrase ?? "")"
                        self.labelNight.text = "Night : \(response.DailyForecasts?[0].day?.iconPhrase ?? "")"
                        
                        
                    }
                }
                
            }
        }
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.viewDidLoad()
        self.viewWillAppear(true)
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.lat = String(userLocation.coordinate.latitude)
        self.long = String(userLocation.coordinate.longitude)
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
