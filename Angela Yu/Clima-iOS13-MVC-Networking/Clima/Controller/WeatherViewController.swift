//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    var weatherManeger = WeatherManeger()
    let locationManeger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManeger.delegate = self
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.requestLocation()
        
        weatherManeger.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func currentLocationPressed(_ sender: Any) {
        locationManeger.requestLocation()
    }
    
}
//MARK: - CLLocationManager
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let locations = locations.last{
            locationManeger.stopUpdatingLocation()
            let lat = locations.coordinate.latitude
            let lon = locations.coordinate.longitude
            print(lat,lon)
            weatherManeger.fetchWeather(latitude: lat, longitude: lon)
        }
    }
}

//MARK: - TextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManeger.fetchWeather(cityName: city)
        }
    }
}
//MARK: - WeatherMAnagerDelegete
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateUi(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

