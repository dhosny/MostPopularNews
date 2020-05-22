// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responce = try? newJSONDecoder().decode(Responce.self, from: jsonData)

import Foundation

// MARK: - Responce
struct ResponceData: Codable {
    var status, copyright: String?
    var numResults: Int?
    var results: [Artical]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results = "results"
    }
}
