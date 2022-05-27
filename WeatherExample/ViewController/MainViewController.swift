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
    var cityNameList : [CityListResponseModel] = []
    
    var isFilteredTextEmpty = true
    var keyWord = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.black
        self.searchBar.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        self.tableView.rowHeight = 44.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
       
      let requestLocation =  TopCitysRequestModel()
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .TopCitiyList, method: .get, parameters: requestLocation.requestPathString()) { (response : [CityListResponseModel] ) in
            
            if response.count > 0 {
                self.cityNameList = response
            }
            
            self.tableView.reloadData()
        }
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cityNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.labelCityName.text = self.cityNameList[indexPath.row].localizedName ?? ""
        return cell
    }
    
    
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            
        }else {
           
            self.isFilteredTextEmpty = false
           
                if searchText.description.lowercased().contains(searchText.lowercased()){
                    self.keyWord = searchText
                }
            
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let requestLocation =  TopCitysRequestModel()
          NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .TopCitiyList, method: .get, parameters: requestLocation.requestPathString()) { (response : [CityListResponseModel] ) in
              
              if response.count > 0 {
                  
                  
              }
          }
       
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
        print(keyWord)
    }
}

