//
//  ViewController.swift
//  API
//
//  Created by Vitali Martsinovich on 2023-02-22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    //MARK: - UI Elements
    
    private let backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topStack: UIStackView = {
        let stack = UIStackView()
         stack.axis = .vertical
         stack.distribution = .equalSpacing
         stack.alignment = .center
         stack.spacing = 15
         stack.translatesAutoresizingMaskIntoConstraints = false
         return stack
    }()
    
    private let weatherImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "nosign")?.withTintColor(.systemRed)
        image.tintColor = .init(named: "myColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let middleStack: UIStackView = {
        let stack = UIStackView()
         stack.axis = .vertical
         stack.distribution = .fill
         stack.alignment = .trailing
         stack.spacing = 0
        stack.contentMode = .scaleToFill
         stack.translatesAutoresizingMaskIntoConstraints = false
         return stack
    }()
    
    private let temperatureStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let tamperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.textColor = .init(named: "myColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = .systemFont(ofSize: 70, weight: .regular)
        label.textColor = .init(named: "myColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels Like:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .init(named: "myColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .init(named: "myColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeCelcLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .init(named: "myColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.contentMode = .scaleToFill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cityLabel: UILabel = {
       let label = UILabel()
        label.text = "Search for weather"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .init(named: "myColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.tintColor = .init(named: "myColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Functions
    
    @objc func searchButtonPressed() {
        
        presentAlert() { [unowned self] city in
            self.weatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        // transfer currentWeather to VC
        weatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tamperatureLabel.text = weather.temperatureString
            self.feelsLikeTempLabel.text = weather.feelLikeTemperatureString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func setupViews() {
        temperatureStack.addArrangedSubview(tamperatureLabel)
        temperatureStack.addArrangedSubview(celsiusLabel)
        feelsLikeStack.addArrangedSubview(feelsLikeLabel)
        feelsLikeStack.addArrangedSubview(feelsLikeTempLabel)
        feelsLikeStack.addArrangedSubview(feelsLikeCelcLabel)
        middleStack.addArrangedSubview(temperatureStack)
        middleStack.addArrangedSubview(feelsLikeStack)
        bottomStack.addArrangedSubview(cityLabel)
        bottomStack.addArrangedSubview(searchButton)
        topStack.addArrangedSubview(weatherImage)
        topStack.addArrangedSubview(middleStack)
        view.addSubview(backgroundImage)
        view.addSubview(topStack)
        view.addSubview(bottomStack)
        
    }

}

extension ViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            weatherImage.heightAnchor.constraint(equalToConstant: 170),
            weatherImage.widthAnchor.constraint(equalToConstant: 170),

            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            topStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchButton.heightAnchor.constraint(equalToConstant: 25),
            searchButton.widthAnchor.constraint(equalToConstant: 25),
            
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        
        ])
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        weatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
