import Foundation
import UIKit

protocol WeatherApiDelegate: AnyObject {
    func didUpdateWeather(_ weather: WeatherModel)
    func didAlert()
}

struct WeatherAPI {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f94426ad8e084969590df7c6f6dda1ad&units=metric"
    
    weak var delegate: WeatherApiDelegate?
    
    func fetchWeather(cityName: String) {
  
        let cityName = cityName.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {

        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, repsonse, error) in
                if error != nil {

                    self.delegate?.didAlert()
                    
                    print(error!)
                    return
                }

                if let safeData = data {
                    if let weatherCity = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(weatherCity)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let humidityAir = decodedData.main.humidity
            let weather = decodedData.weather[0].main
            let description = decodedData.weather[0].description
            let wind = decodedData.wind.speed
            let tempMax = decodedData.main.temp_max
            let tempMin = decodedData.main.temp_min
            let sensedTemp = decodedData.main.feels_like
            
            let weatherCity = WeatherModel(temperature: temp, humidity: humidityAir, descriptionWeather: description, weatherMain: weather, windSpeed: wind, tempMax: tempMax, tempMin: tempMin, sensedTemp: sensedTemp)
            return weatherCity
            
        } catch {
            print("Something gone wrong")
            return nil
        }
    }
}

struct WeatherModel {
    let temperature: Double
    let humidity: Int
    let descriptionWeather: String
    let weatherMain: String
    let windSpeed: Double
    let tempMax: Double
    let tempMin: Double
    let sensedTemp: Double
}
