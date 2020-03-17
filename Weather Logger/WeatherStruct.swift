//
//  WeatherStruct.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.//

import UIKit

struct WeatherStruct: Decodable {
    let weather: [EeatherData]
    let main: MainData
    let name: String
}

struct EeatherData: Decodable {
    let description: String
}

struct MainData: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}
