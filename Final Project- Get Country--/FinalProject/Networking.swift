
import Foundation

func getCountryName(input: String) -> String {

    var countryName: String = ""
    
    do {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(input)&APPID=446e53dcd2103976eb4c48b6fd1640ea"
        let escapedString = url.replacingOccurrences(of: " ", with: "+")
        let appURL = URL(string: escapedString)!
        let data = try Data(contentsOf: appURL)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        let sys = json["sys"] as! [String:Any]
        countryName = sys ["country"] as? String ?? ""
    }
    catch {
        countryName = "error"
    }

    return countryName

}
