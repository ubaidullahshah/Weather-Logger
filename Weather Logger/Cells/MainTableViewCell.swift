//
//  MainTableViewCell.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellData(model: WeatherInfo) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY HH:mm"
        lblDate.text = dateFormatter.string(from: model.date)
        lblDescription.text = model.description
        lblTemp.text = "\(self.tempToCelsius(TempF: model.temp)) °c";//model.temp
    }
    
    func tempToCelsius (TempF: String) -> Int{
     
        let newTemp = (Int(TempF)! - Int(273.15))
        return newTemp
    }
}
