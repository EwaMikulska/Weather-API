
import UIKit

class WeatherDetailsViewController: UIViewController, WeatherApiDelegate {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var sensedTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var arrowBack: UIButton!
    
    var weatherAPI = WeatherAPI()
    
    var dataFromVC : String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherAPI.delegate = self
        
        cityNameLabel.text = dataFromVC
        
        if let city = cityNameLabel.text {
        weatherAPI.fetchWeather(cityName: city)
        }
        
    }
    
    @IBAction func arrowBackPressed(_ sender: Any) {
        print("Button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.temperatureLabel.text = "The temperature is \(String(weather.temperature))*C"
            self.weatherLabel.text = weather.weatherMain
            self.weatherDescriptionLabel.text = weather.descriptionWeather
            self.humidityLabel.text = "Humidity is \(String(weather.humidity))%"
            self.windSpeedLabel.text = "The wind speed is \(weather.windSpeed)km/h"
            self.minTemperatureLabel.text = "Minimum temperature is \(String(weather.tempMin))*C"
            self.maxTemperatureLabel.text = "Maximum temperature is \(String(weather.tempMax))*C"
            self.sensedTemperatureLabel.text = "Sensed temperature is \(String(weather.sensedTemp))*C"
        }
    }
    
    func didAlert(){
        DispatchQueue.main.async { [weak self] in
            let alertError = UIAlertController(title: "ERROR", message: "Please try again", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            alertError.addAction(alertAction)
            self?.present(alertError, animated: true, completion: nil)
        }
    }
}
