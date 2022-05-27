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
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
