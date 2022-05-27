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
    var cityNameList : [CityListResponseModel] = []
    var searchHistoryList : [String] = []
    var isFilteredTextEmpty = true
    var keyWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.delegate = self
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        self.tableView.rowHeight = 44.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
        
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
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            self.cityNameList = []
            self.tableView.reloadData()
            self.tableView.isHidden = true
            self.viewSearchHistoryView.isHidden = false
        }else {
            self.viewSearchHistoryView.isHidden = true
            self.tableView.isHidden = false
            self.isFilteredTextEmpty = false
           
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
        if self.searchHistoryList.count == 6 {
            self.searchHistoryList.remove(at: 0)
        }
        self.searchHistoryList.append(self.keyWord)
        self.viewSearchHistoryView.searchHistoryList = self.searchHistoryList
        self.viewSearchHistoryView.tableView.reloadData()
        self.keyWord = ""
    }
}


