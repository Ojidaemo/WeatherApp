//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Vitali Martsinovich on 2023-02-24.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    let feelsLikeTemperature: Double
    var feelLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    init?(weatherData: WeatherData) {
        cityName = weatherData.name
        temperature = weatherData.main.temp
        feelsLikeTemperature = weatherData.main.feelsLike
        conditionCode = weatherData.weather.first!.id
    }
}
