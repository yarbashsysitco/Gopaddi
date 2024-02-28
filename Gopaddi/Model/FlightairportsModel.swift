

import Foundation


struct FlightairportsModel: Codable {
    let code: String
    let result: [Airport]?
}

struct Airport: Codable {
    let code: String
    let label: String
    let value: String
}

//
//
//{
//   "code":"200",
//   "airports":[
//      {
//         "code":"DXB",
//         "label":"Dubai, United Arab Emirates - Dubai (DXB)",
//         "value":"Dubai, United Arab Emirates - Dubai (DXB)"
//      },
//      {
//         "code":"XMB",
//         "label":"Dubai, United Arab Emirates - Marina Mall EY Bus Station (XMB)",
//         "value":"Dubai, United Arab Emirates - Marina Mall EY Bus Station (XMB)"
//      },
//      {
//         "code":"XNB",
//         "label":"Dubai, United Arab Emirates - Dubai Bus Station (XNB)",
//         "value":"Dubai, United Arab Emirates - Dubai Bus Station (XNB)"
//      }
//   ]
//}
//
