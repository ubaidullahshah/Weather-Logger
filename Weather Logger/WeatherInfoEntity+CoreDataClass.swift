//
//  WeatherInfoEntity+CoreDataClass.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WeatherInfoEntity)
public class WeatherInfoEntity: NSManagedObject {
    convenience init() {
        let context = CoreDataHelper.sharedInstance.context
        self.init(context: context)
    }
    
     convenience init(data: WeatherInfo) {
        self.init()
        self.name = data.name;
        self.date = data.date;
        self.tempDescription = data.description;
        self.temp = data.temp;
        CoreDataHelper.sharedInstance.saveContext()

    }
    
    
    
     static func getAll() -> [WeatherInfoEntity] {
        return CoreDataHelper.sharedInstance.fetchAll(entity: WeatherInfoEntity.description()) as? [WeatherInfoEntity] ?? []
    }
    
     static func getWith(date: Date) -> WeatherInfoEntity? {
        let predicate = NSPredicate(format: "date == %@", date as NSDate)
        var item: WeatherInfoEntity?
        let items = CoreDataHelper.sharedInstance.fetch(entity: WeatherInfoEntity.description(), predicate: predicate)
        if items.count > 0 {
            item = items[0] as? WeatherInfoEntity
        }
        return item
    }
    
}
