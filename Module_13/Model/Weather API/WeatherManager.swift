import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5b37f90edb8a4704013e4e1dd95771ad&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let sesstion = URLSession(configuration: .default)
            
            //3. Give the session task
            let task = sesstion.dataTask(with: url, completionHandler: {data, response, error in
                guard error == nil else {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(safeData)
                }
            })
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data){
        // default JSON decoder
        let decoder = JSONDecoder()
        // if decoding will go wrong, we will catch an error
        do{
            // creating an object of type WeatherData and write data with the same var name inside object
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            delegate?.didUpdateWeather(weather: weather)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
}

extension WeatherManager {
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
}
