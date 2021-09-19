import Foundation

struct ExchangeRate: Codable {
    let success: Bool?
    let timestamp: Date?
    let base: String?
    let date: String?
    let rates: [String: Double]?
}

