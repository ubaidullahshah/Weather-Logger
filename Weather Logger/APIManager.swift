//
//  APIManager.swift
//  Weather Logger
//
//  Created by Syed Ubaid Khan on 3/15/20.
//  Copyright © 2020 Syed Ubaid Khan. All rights reserved.
//

import Foundation
import UIKit

enum MedodReadData: String {
    case GET = "GET"
    case POST = "POST"
}

final class APIManager {
    
    static func getDataFromServer(metod: MedodReadData, url: String, inputData: [String: String]?, completionHandler: @escaping (Data?) -> Void) {
        
        let urlF = (url).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        print(urlF)
        guard let url = URL(string: urlF) else {
            completionHandler(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = metod.rawValue
        
        if let data = inputData {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status request - \(response.statusCode)")
            }
            
            if let data = data {
                do {
                    print(try JSONSerialization.jsonObject(with: data, options: []))
                } catch {
                    print(error)
                }
            }
        
            completionHandler(data)
            
            }.resume()
    }
    
    static func loadDataPOSTArray<T: Decodable>(structData: T.Type, url: String, completionHandler: @escaping (T?) -> Void) {
        APIManager.getDataFromServer(metod: .POST, url: url, inputData: nil) { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let json = try JSONDecoder().decode(structData.self, from: data)
                        completionHandler(json)
                    } catch {
                        print(error)
                        completionHandler(nil)
                    }
                }
            } else {
                completionHandler(nil)
            }
        }
    }
}
