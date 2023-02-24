//
//  WeatherManager.swift
//  API
//
//  Created by Vitali Martsinovich on 2023-02-23.
//

import Foundation

struct WeatherManager {
    
    func fetchCurrentWeather(forCity city: String, completionHandler: @escaping (CurrentWeather) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric&q=\(city)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    completionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
           let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(weatherData: weatherData)
            else {
                return nil
            }
            return currentWeather
        } catch {
            print(error)
        }
        return nil
    }
}