struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<300: return "cloud.bolt"
        case 300..<400: return "cloud.drizzle"
        case 500..<600: return "cloud.rain"
        case 600..<700: return "cloud.snow"
        case 701..<800: return "cloud.fog"
        case 801,802: return "cloud.sun"
        case 803..<900: return "cloud"
        default: return "sun.max"
        }
    }
}
