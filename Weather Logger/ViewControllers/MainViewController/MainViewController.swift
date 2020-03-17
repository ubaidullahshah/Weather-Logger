//
//  MainViewController.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import JGProgressHUD

class MainViewController: UIViewController,CLLocationManagerDelegate {
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    var lat : String = ""
    var long : String = ""
    var weatherData : [WeatherInfo] = []
    var currentWeatherData : WeatherInfo?
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        let data = WeatherInfoEntity.getAll().reversed()
        for item in data {
            let wData = WeatherInfo.init(weatherData: item)
            weatherData.append(wData!)
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        if currentWeatherData != nil {
            var savedData = WeatherInfoEntity.getWith(date: currentWeatherData!.date)
                  if !(savedData != nil) {
                      savedData = WeatherInfoEntity(data: currentWeatherData!)
                      loadLiveData()
                  }
        }
      
    }
    //Obtains latitude (lat) and longitude (long)
       func locationManager(_ manager: CLLocationManager,
                            didUpdateLocations locations: [CLLocation])
       {
           let latestLocation: CLLocation = locations[locations.count - 1]
           
           lat = String(format: "%.4f",
                                  latestLocation.coordinate.latitude)
           long = String(format: "%.4f",
                                   latestLocation.coordinate.longitude)
           if startLocation == nil {
               startLocation = latestLocation
            loadLiveData()
           }

       }
       
       
       func locationManager(_ manager: CLLocationManager,
                            didFailWithError error: Error) {
       }
    private func loadLiveData() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=2ab2395d40cc7956cc7bb9d13a2b1776"
        APIManager.loadDataPOSTArray(structData: WeatherStruct.self, url: url) { (data) in
            hud.dismiss(animated: true)
            DispatchQueue.main.async {
                if let data = data {
                    
                    let wData = WeatherInfo.init(data: data)
                    wData?.date = Date();
                    self.weatherData.insert(wData!, at: 0)
                    self.currentWeatherData = wData
                    self.tableview.reloadData()
                
                } else {
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
         let model = weatherData[indexPath.row]
            cell.loadCellData(model: model)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
