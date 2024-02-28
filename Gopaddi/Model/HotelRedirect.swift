import Foundation

struct HotelRedirect: Codable {
    let code: String
    let result: [HotelRedirectResult]
}

struct HotelRedirectResult: Codable {
    let hb_id: String
    let hb_ref: String
    let hb_check_in: String
    let hb_check_out: String
    let hb_rooms: String
    let hb_nights: String
    let hb_adults: String
    let hb_childs: String
    let hb_amount: String
    let contact: [HotelContact]
    let totalPrice: String
    let currency: String
    let hb_cancelled: String
    let hb_failed: String
    let bookingStatus: String
    let hb_created_at: String
}

struct HotelContact: Codable {
    let fname: String
    let lname: String
    let phone: String
    let email: String
}
