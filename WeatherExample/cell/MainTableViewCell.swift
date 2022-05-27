//
//  MainTableViewCell.swift
//  WeatherExample
//
//  Created by Yasin Dalkilic on 27.05.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var labelCityName: UILabel!
    var localized : CityListResponseModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



