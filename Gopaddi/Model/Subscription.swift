import Foundation

struct UserSubscription: Codable {
    let code: String
    let subscription: [Subscription]
    let personal: [Personal]?
    let interests: [[String]]?
    let status: String

    enum CodingKeys: String, CodingKey {
        case code
        case subscription
        case personal
        case interests
        case status
    }

    // Custom initializer to handle empty personal and interests arrays
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.subscription = try container.decode([Subscription].self, forKey: .subscription)
        self.status = try container.decode(String.self, forKey: .status)

        // Handle optional personal and interests
        self.personal = try? container.decode([Personal].self, forKey: .personal)
        self.interests = try? container.decode([[String]].self, forKey: .interests)
    }

    // Custom encode method to handle empty personal and interests arrays
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encode(subscription, forKey: .subscription)
        try container.encode(status, forKey: .status)

        // Encode optional personal and interests only if they are non-nil
        if let personal = personal {
            try container.encode(personal, forKey: .personal)
        }
        if let interests = interests {
            try container.encode(interests, forKey: .interests)
        }
    }
}

struct Payment: Codable {
    let key, reference, transaction_id, amount: String?
    let currency, method, status, created_at: String?
}

struct Personal: Codable {
    let uname: String
    let dob: String
    let gender: String
    let picture: String
}

struct Subscription: Codable {
    let membership: String
    let plan: String
    let status: String
}
