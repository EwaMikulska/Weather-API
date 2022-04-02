import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityTableView: UITableView!
    
    let weatherDetailsViewController = WeatherDetailsViewController(nibName: "WeatherDetailsViewController", bundle: nil)
  
    var cityNames: [CityTableView] = [
        CityTableView(cityName: "Warsaw"),
        CityTableView(cityName: "Tirana"),
        CityTableView(cityName: "Saigon"),
        CityTableView(cityName: "New York"),
        CityTableView(cityName: "Mexico"),
        CityTableView(cityName: "Barcelona"),
        CityTableView(cityName: "Pretoria")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Application"
        searchTextField.textColor = .black
        cityTableView.dataSource = self
        searchTextField.delegate = self
        cityTableView.delegate = self
        cityTableView.layer.cornerRadius = 30
        
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        searchFromTextField()
    }
    
    func searchFromTextField() {
        let dataToPass = searchTextField.text
        let detailsVC = WeatherDetailsViewController(nibName: "WeatherDetailsViewController", bundle: nil)
        detailsVC.dataFromVC = dataToPass
        
        self.present(detailsVC, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
     
            searchFromTextField()
            
            return true
        } else {
          
            let alert = UIAlertController(title: "ALERT", message: "Please enter city", preferredStyle: .alert)
            let action = UIAlertAction (title: "Confirm", style: .default) { (action) in
            }
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        searchTextField.text = ""
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = cityNames[indexPath.row].cityName
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataToPass = cityNames[indexPath.row].cityName
        let detailsVC = WeatherDetailsViewController(nibName: "WeatherDetailsViewController", bundle: nil)
        detailsVC.dataFromVC = dataToPass
        
        self.present(detailsVC, animated: true, completion: nil)
        
    }
    
}
