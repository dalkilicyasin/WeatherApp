//
//  WeatherDetailViewController.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet var viewWeatherDetailView: WeatherDetailView!
    var weatherCondition : ForeCastResponseModel?
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWeatherDetailView.labelHeader.text = "\(self.cityName) Weather Detail"
        self.viewWeatherDetailView.labelHighTempatura.text = "High Tempature : \(self.weatherCondition?.DailyForecasts?[0].temperature?.maximum?.value ?? 0.0)F"
        self.viewWeatherDetailView.labelLowestTempature.text = "Lowest Tempature : \(self.weatherCondition?.DailyForecasts?[0].temperature?.minimum?.value ?? 0.0)F"
        self.viewWeatherDetailView.labelDayCommit.text = "Dayly : \(self.weatherCondition?.DailyForecasts?[0].day?.iconPhrase ?? "")"
        self.viewWeatherDetailView.labelNightCommit.text = "Night : \(self.weatherCondition?.DailyForecasts?[0].day?.iconPhrase ?? "")"
        
        }
    
    init (weatherCondition : ForeCastResponseModel, cityName : String){
         self.weatherCondition = weatherCondition
         self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
