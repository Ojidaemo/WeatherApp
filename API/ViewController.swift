//
//  ViewController.swift
//  API
//
//  Created by Vitali Martsinovich on 2023-02-22.
//

import UIKit

class ViewController: UIViewController {
    
    private let backgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "cloud.sun")?.withTintColor(.systemRed)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let temperatureStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.contentMode = .scaleToFill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let tamperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .trailing
        stack.contentMode = .scaleToFill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels Like:"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.text = "23"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeCelcLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .trailing
        stack.contentMode = .scaleToFill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cityLabel: UILabel = {
       let label = UILabel()
        label.text = "Minsk"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    @objc func searchButtonPressed() {
        
    }
    
    func setupViews() {
        temperatureStack.addArrangedSubview(tamperatureLabel)
        temperatureStack.addArrangedSubview(celsiusLabel)
        feelsLikeStack.addArrangedSubview(feelsLikeLabel)
        feelsLikeStack.addArrangedSubview(feelsLikeTempLabel)
        feelsLikeStack.addArrangedSubview(feelsLikeCelcLabel)
        bottomStack.addArrangedSubview(cityLabel)
        bottomStack.addArrangedSubview(searchButton)
        view.addSubview(backgroundImage)
        view.addSubview(weatherImage)
        view.addSubview(temperatureStack)
        view.addSubview(feelsLikeStack)
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
            
            weatherImage.heightAnchor.constraint(equalToConstant: 100),
            weatherImage.widthAnchor.constraint(equalToConstant: 100),
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            temperatureStack.topAnchor.constraint(equalTo: weatherImage.bottomAnchor,constant: 10),
            temperatureStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureStack.heightAnchor.constraint(equalToConstant: 100),
            temperatureStack.widthAnchor.constraint(equalToConstant: 100),
            
            feelsLikeStack.topAnchor.constraint(equalTo: temperatureStack.bottomAnchor),
            feelsLikeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        
        ])
    }
}
