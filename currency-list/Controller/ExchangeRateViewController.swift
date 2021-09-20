import Foundation

final class ExchangeRateViewController {
    
    let exchangeRate = ExchangeRate
    
    private func getExchangeRates() {
        let url = URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=32280c594400cd5011e8045014963547")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
