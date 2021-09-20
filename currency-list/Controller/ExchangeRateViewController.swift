import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!    
    var exchangeRates: ExchangeRate? = nil
    
    func getExchangeRatesFromURL(completion: @escaping() -> Void) {
        let url = URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=XXXXX")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            self.exchangeRates = self.parseExchange(with: data)
            completion()
        }
        task.resume()
    }
    
    private func parseExchange(with data: Data) -> ExchangeRate {
        let decoder = JSONDecoder()
        let exchangeRates = try! decoder.decode(ExchangeRate.self, from: data)
        return exchangeRates
    }
}

extension ExchangeRateViewController: UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getExchangeRatesFromURL() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension ExchangeRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let exchangeRates = exchangeRates?.rates else { return 0 }
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeCell") as! ExchangeRatesTableViewCell
        guard let countries = exchangeRates?.rates?.keys.map({$0}) else { return cell}
        guard let values = exchangeRates?.rates?.values.map({$0}) else { return cell }
        let currentCountry = String(countries[indexPath.row])
        let currentValue = String(values[indexPath.row])
        cell.rateValue.text = currentCountry + ": " + currentValue
        return cell
    }
}
