import Foundation

struct ExchangeRate: Decodable {
    let success: Bool?
    let timestamp: Date?
    let base: String?
    let date: String?
    let rates: [String: Double]?
}

