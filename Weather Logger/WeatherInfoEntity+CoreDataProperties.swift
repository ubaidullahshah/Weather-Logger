//
//  WeatherInfoEntity+CoreDataProperties.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfoEntity> {
        return NSFetchRequest<WeatherInfoEntity>(entityName: "WeatherInfoEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var temp: String?
    @NSManaged public var tempDescription: String?
    @NSManaged public var date: Date?

}
