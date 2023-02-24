//
//  AlertVC.swift
//  WeatherApp
//
//  Created by Vitali Martsinovich on 2023-02-23.
//

import UIKit

extension ViewController {
    
    func presentAlert(completionHandler: @escaping (String) -> Void) {
        
//        var textField = UITextField()
        
        let alert = UIAlertController(title: "Enter city name", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter city name here"
//            textField = alertTextField
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { search in
            //what should happen once the user clicks search button
            let textField = alert.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                // transform two words with separator " " into one word (New York for example) so we can use it for searching weather
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { cancel in
            //what should happen once the user clicks cancel
        }
        
        
        
        alert.addAction(search)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
