//
//  LoginView.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 26.05.2022.
//
import Foundation
import UIKit


class MainView : UIView {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelCityList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.black
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        self.labelCityList.isHidden = true
     
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
