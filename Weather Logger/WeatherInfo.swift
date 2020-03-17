//
//  WeatherInfo.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.

//

import UIKit

class WeatherInfo {
    var name: String
    let temp: String
    let description: String
    var date: Date
    
    init?(data: WeatherStruct) {
        self.temp = String(Int(data.main.temp))
        self.description = data.weather[0].description
        self.date = Date();//Date(timeIntervalSince1970: TimeInterval(data.))
        self.name = data.name
    }
    
    init?(weatherData: WeatherInfoEntity) {
        self.temp = weatherData.temp!
        self.description = weatherData.tempDescription!
        self.date = weatherData.date!
        self.name = weatherData.name!
    }
}
