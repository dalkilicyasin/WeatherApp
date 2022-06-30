//
//  ViewController.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 26.05.2022.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewSearchHistoryView: SearchHistoryView!
    @IBOutlet var viewMainView: MainView!
    var cityName = ""
    var cityNameList : [CityListResponseModel] = []
    var searchHistoryList : [String] = []
    var isFilteredTextEmpty = true
    var keyWord = ""
    var cityCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.delegate = self

        print("3.branc ilk yorum")


    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        self.tableView.rowHeight = 44.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchHistoryUpdate()
    }
    
    @IBAction func CurrentWeatherButtonTapped(_ sender: Any) {
        self.weatherPushViewController(viewController: MyLocationViewController())
    }
    
    func searchHistoryUpdate(){
        if  self.searchHistoryList.count == 6 {
            self.searchHistoryList.remove(at: 0)
        }
        self.viewSearchHistoryView.searchHistoryList = self.searchHistoryList
        self.viewSearchHistoryView.tableView.reloadData()
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cityNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.labelCityName.text = self.cityNameList[indexPath.row].administrativeArea?.localizedName ?? ""
        cell.localized = self.cityNameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cityName = self.cityNameList[indexPath.row].administrativeArea?.localizedName ?? ""
        self.cityCode = self.cityNameList[indexPath.row].Key ?? ""
        let foreCastRequestModel = ForeCastRequestModel.init(cityCode: self.cityCode)
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .ForeCast, method: .get, parameters: foreCastRequestModel.requestPathString()) { (response : ForeCastResponseModel ) in
              
            if response.DailyForecasts != nil {
                self.weatherPushViewController(viewController: WeatherDetailViewController(weatherCondition: response, cityName: self.cityName))
              }
          }
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            self.cityNameList = []
            self.tableView.reloadData()
            self.tableView.isHidden = true
            self.viewSearchHistoryView.isHidden = false
            self.viewMainView.labelCityList.isHidden = true
            self.viewMainView.labelCurrentLocation.isHidden = false
        }else {
            self.viewSearchHistoryView.isHidden = true
            self.tableView.isHidden = false
            self.isFilteredTextEmpty = false
            self.viewMainView.labelCityList.isHidden = false
            self.viewMainView.labelCurrentLocation.isHidden = true
                if searchText.description.lowercased().contains(searchText.lowercased()){
                    self.keyWord = searchText
                    let requestSearchText =  SearchLocationRequestModel.init(searchText: self.keyWord)
                    NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .SearchCitys, method: .get, parameters: requestSearchText.requestPathString()) { (response : [CityListResponseModel] ) in
                          
                          if response.count > 0 {
                              self.cityNameList = response
                              self.tableView.reloadData()
                          }
                      }
                }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
        print(self.keyWord)
        if self.searchHistoryList.count > 0 {
            if let insideIndex = self.searchHistoryList.firstIndex(where: {$0 == self.keyWord}){
                self.searchHistoryList.remove(at: insideIndex)
            }
        }
        self.searchHistoryList.append(keyWord)
        self.searchHistoryUpdate()
        self.keyWord = ""
    }
}


