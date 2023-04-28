
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5b37f90edb8a4704013e4e1dd95771ad&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
