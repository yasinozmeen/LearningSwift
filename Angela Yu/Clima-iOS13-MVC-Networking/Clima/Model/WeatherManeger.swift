//
//  WeatherManeger.swift
//  Clima
//
//  Created by Kadir Yasin Özmen on 9.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManeger{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=5eef30d511ffb60c299bb32275f53f28&units=metric&q="
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)\(cityName)"
        
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        
        // create a url
        if let url = URL(string: urlString){
            
            // crate a URLSession and define url
            let session = URLSession(configuration: .default)
            
            // start task
            let task = session.dataTask(with: url){ (data, response,eror) in
                
                if eror != nil{
                    print(eror!)
                    return
                }
                
                if let safeData = data{
                    parseJson(weatherData: safeData)
                }
            }
            // fetch information
            task.resume()
        }
    }
    func parseJson(weatherData:Data){
      let decoder = JSONDecoder()
        do{
         let decodeData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodeData.weather[0].id
            let cityName = decodeData.name
            let temperature = decodeData.main.temp
            
            let weather = WeatherModel(id: id, cityName: cityName, temperature: temperature)
            
            print(weather.temperature)
        }catch{
            print(error)
        }
        
    }
         
}
