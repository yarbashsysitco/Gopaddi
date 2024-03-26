import Foundation

struct UserTokenModel: Codable {
    let success: Bool
    let code: String
    let message: String?
    let data: [Datum]?
    let errors: [ErrorDetail]?

    private enum CodingKeys: String, CodingKey {
        case success, code, message, data, errors
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)

        // Decode "success" as a string and convert it to a boolean if possible
        if let successString = try? container.decode(String.self, forKey: .success) {
            self.success = (successString.lowercased() == "true")
        } else {
            // Fallback to decoding directly as a boolean
            self.success = try container.decode(Bool.self, forKey: .success)
        }

        // Decode "message" as optional string
        self.message = try container.decodeIfPresent(String.self, forKey: .message)

        // Decode "data" array if present
        self.data = try container.decodeIfPresent([Datum].self, forKey: .data)

        // Decode "errors" array
        self.errors = try container.decodeIfPresent([ErrorDetail].self, forKey: .errors)
    }
}

struct Datum: Codable {
    let userId: String
}

struct ErrorDetail: Codable {
    let userToken: String
}
