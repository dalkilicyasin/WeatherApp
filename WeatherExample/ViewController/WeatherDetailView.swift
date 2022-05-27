//
//  WeatherDetailView.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.
//

import Foundation
import UIKit


class WeatherDetailView : UIView {
    @IBOutlet weak var labelHighTempatura: UILabel!
    @IBOutlet weak var labelLowestTempature: UILabel!
    @IBOutlet weak var labelDayCommit: UILabel!
    @IBOutlet weak var labelNightCommit: UILabel!
    @IBOutlet weak var labelHeader: UILabel!
    
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
