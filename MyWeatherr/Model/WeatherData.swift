import Foundation

struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
}

struct Weather: Decodable {
    let description: String
    let main: String
}


struct Wind: Decodable {
    let speed: Double
}
