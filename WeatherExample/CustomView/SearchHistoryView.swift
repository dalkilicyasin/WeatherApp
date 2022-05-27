//
//  SearchHistoryView.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.

import Foundation
import UIKit

protocol SearchHistoryDelegate {
    func searchDelegateFunc(searchList : [String])
}

class SearchHistoryView : UIView {
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var searchHistoryList : [String] = []
    var searchHistoryDelegate : SearchHistoryDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: SearchHistoryView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        
    }
}

extension SearchHistoryView : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as! MainTableViewCell
        cell.labelCityName.text = self.searchHistoryList[indexPath.row]
        return cell
    }
}
