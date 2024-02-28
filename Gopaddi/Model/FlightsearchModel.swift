import Foundation

// MARK: - FlightSearchModel
struct FlightsearchModel: Codable {
    let code: String
    let result: [FlightResult]
}
// MARK: - FlightResult
struct FlightResult: Codable {
    let onewaydata: [Onewaydatas]
}

// MARK: - FlightDetails
struct Onewaydatas: Codable {
//    let flight_t_id: Int?
//    let session_id: String?
//    let uniqueRefNo: String?
//    let groupInd: Int?
//    let api: String?
//    let Origin: String?
//    let Destination: String?
      let Adults: String?
//    let Childs: String?
//    let Infants: String?
//    let DirectionInd: String?
      let Total_Duration: Int?
      let DepartureDateTime: [String]?
      let ArrivalDateTime: [String]?
      let Duration: [String]?
//    let FlightNumber: [String]?
//    let ResBookDesigCode: [String]?
//    let FareType: String?
//    let SeatToSell: [String]?
//    let Cabin: [String]?
//    let Meal: String?
//    let service_charge: Int?
//    let vat: Double?
      let Departure_LocationCode: [String]?
      let Arrival_LocationCode: [String]?
      let AirEquipType: [String]?
      let OperatingAirline_Code: [String]?
//    let MarketingAirline_Code: [String]?
      let OperatingAirline_FlightNumber: [String]?
//    let StopQuantity: [String]?
      let Stops: Int?
//    let BaseFare: Int?
//    let discount: Int?
//    let ordinary_discount: Int?
//    let discount_markup: Int?
//    let BaseFare_CurrencyCode: String?
//    let EquivFare: Int?
      let CurrencyCode: String?
//    let Tax_Amount: Int?
//    let Tax_Code: String?
      let TotalFare: Double?
//    let netfare: Int?
//    let PassengerType: [String]?
//    let PassengerQuantity: [String]?
//    let PassengerBaseFare: [String]?
//    let PassengerEquivFare: [String]?
//    let PassengerTotalTax: [String]?
//    let PassengerTotalFare: [String]?
//    let Trip_Type: String?
      let BaggageInformation: [[BaggageInfo]]?
//    let Admin_Markup: Double?
//    let Agent_Markup: Int?
//    let Payment_Charge: Int?
//    let admincancellationamount: Int?
//    let apicancellationamount: Int?
//    let Origin_Text: String?
//    let Destination_Text: String?
      let Departure_LocationText: [String]?
      let Arrival_LocationText: [String]?
      let OperatingAirline_Text: [String]?
//    let MarketingAirline_Text: [String]?
      let Cabin_Text: [String]?
//    let PassengerTypeText: [String]?
      let OperatingAirline_Image: [String]?
      let returndata: [returndatas]?
}

struct returndatas: Codable {
    //    let flight_t_id: Int?
    //    let session_id: String?
    //    let uniqueRefNo: String?
    //    let groupInd: Int?
    //    let api: String?
    //    let Origin: String?
    //    let Destination: String?
          let Adults: String?
    //    let Childs: String?
    //    let Infants: String?
    //    let DirectionInd: String?
          let Total_Duration: Int?
          let DepartureDateTime: [String]?
          let ArrivalDateTime: [String]?
    //    let Duration: [String]?
    //    let FlightNumber: [String]?
    //    let ResBookDesigCode: [String]?
    //    let FareType: String?
    //    let SeatToSell: [String]?
    //    let Cabin: [String]?
    //    let Meal: String?
    //    let service_charge: Int?
    //    let vat: Double?
          let Departure_LocationCode: [String]?
          let Arrival_LocationCode: [String]?
          let AirEquipType: [String]?
          let OperatingAirline_Code: [String]?
    //    let MarketingAirline_Code: [String]?
          let OperatingAirline_FlightNumber: [String]?
    //    let StopQuantity: [String]?
          let Stops: Int?
    //    let BaseFare: Int?
    //    let discount: Int?
    //    let ordinary_discount: Int?
    //    let discount_markup: Int?
    //    let BaseFare_CurrencyCode: String?
    //    let EquivFare: Int?
          let CurrencyCode: String?
    //    let Tax_Amount: Int?
    //    let Tax_Code: String?
          let TotalFare: Double?
    //    let netfare: Int?
    //    let PassengerType: [String]?
    //    let PassengerQuantity: [String]?
    //    let PassengerBaseFare: [String]?
    //    let PassengerEquivFare: [String]?
    //    let PassengerTotalTax: [String]?
    //    let PassengerTotalFare: [String]?
    //    let Trip_Type: String?
    //    let BaggageInformation: [[BaggageInfo]]?
    //    let Admin_Markup: Double?
    //    let Agent_Markup: Int?
    //    let Payment_Charge: Int?
    //    let admincancellationamount: Int?
    //    let apicancellationamount: Int?
    //    let Origin_Text: String?
    //    let Destination_Text: String?
          let Departure_LocationText: [String]?
          let Arrival_LocationText: [String]?
          let OperatingAirline_Text: [String]?
    //    let MarketingAirline_Text: [String]?
          let Cabin_Text: [String]?
    //    let PassengerTypeText: [String]?
          let OperatingAirline_Image: [String]?
}


// MARK: - BaggageInfo
struct BaggageInfo: Codable {
    let Pieces: Int?
    let Weight: Int?
    let Unit  : String?
   
}

// Please note that the code has been compiled by merging the structures from the provided code snippets. Ensure you verify and adjust data types and other aspects to match your specific requirements.
//{
//    let flight_t_id: Int
//    let session_id: String
//    let uniqueRefNo: String
//    let groupInd: Int
//    let api: String
//    let Origin: String
//    let Destination: String
//    let Adults: String
//    let Childs: String
//    let Infants: String
//    let DirectionInd: String
//    let Total_Duration: Int
//    let DepartureDateTime: [String]
//    let ArrivalDateTime: [String]
//    let Duration: [String]
//    let FlightNumber: [String]
//    let ResBookDesigCode: [String]
//    let FareType: String
//    let SeatToSell: [String]
//    let Cabin: [String]
//    let Meal: String
//    let service_charge: Int
//    let vat: Double
//    let Departure_LocationCode: [String]
//    let Arrival_LocationCode: [String]
//    let AirEquipType: [String]
//    let OperatingAirline_Code: [String]
//    let MarketingAirline_Code: [String]
//    let OperatingAirline_FlightNumber: [String]
//    let StopQuantity: [String]
//    let Stops: Int
//    let BaseFare: Int
//    let discount: Int
//    let ordinary_discount: Int
//    let discount_markup: Int
//    let BaseFare_CurrencyCode: String
//    let EquivFare: Int
//    let CurrencyCode: String
//    let Tax_Amount: Int
//    let Tax_Code: String
//    let TotalFare: Double
//    let netfare: Int
//    let PassengerType: [String]
//    let PassengerQuantity: [String]
//    let PassengerBaseFare: [String]
//    let PassengerEquivFare: [String]
//    let PassengerTotalTax: [String]
//    let PassengerTotalFare: [String]
//    let Trip_Type: String
//    let BaggageInformation: [[BaggageInfo]]
//    let Admin_Markup: Double
//    let Agent_Markup: Int
//    let Payment_Charge: Int
//    let admincancellationamount: Int
//    let apicancellationamount: Int
//    let Origin_Text: String
//    let Destination_Text: String
//    let Departure_LocationText: [String]
//    let Arrival_LocationText: [String]
//    let OperatingAirline_Text: [String]
//    let MarketingAirline_Text: [String]
//    let Cabin_Text: [String]
//    let PassengerTypeText: [String]
//    let OperatingAirline_Image: [String]
//}





//        if let flightResult = Flightsearch?.result[indexPath.row] {
//            if let returnData = flightResult.onewaydata.first?.returndata {
//                if indexPath.row < returnData.count {
//                    let returnFlight = returnData[indexPath.row]
//
//                    // You can use the returnFlight object to populate the return flight data in your cell
//                    // Example:
//                    // Set the return flight departure time
//                    if let returnDepartureTimes = returnFlight.DepartureDateTime {
//                        if let firstDepartureTime = returnDepartureTimes.first {
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//                            if let date = dateFormatter.date(from: firstDepartureTime) {
//                                dateFormatter.dateFormat = "HH:mm"
//                                let timeString = dateFormatter.string(from: date)
//                                cell.returnDeparturTimeLb.text = timeString
//                            }
//                        }
//                    }
//
//
//                    if let returnDeparturDate = returnFlight.DepartureDateTime {
//                        if let returnDeparturDates = returnDeparturDate.first {
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//                            if let date = dateFormatter.date(from: returnDeparturDates) {
//                                dateFormatter.dateFormat =  "dd MMM, EEE"
//                                let timeString = dateFormatter.string(from: date)
//                                cell.returnDeparturDateLb.text = timeString
//
//                            }
//                        }
//                    }
//
//
//
//                }
//            }
//        }


//return cell
//
//}
//
//func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
////        return 165
//return 197
//}
//
//
//
//
//}

//
//if let returnData = firstOneway.returndata, indexPath.row < returnData.count {
//        if let returnDeparturTime = returnData[indexPath.row].DepartureDateTime {
//        if let returnDeparturTimes = returnDeparturTime.first {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//            if let date = dateFormatter.date(from: returnDeparturTimes) {
//                dateFormatter.dateFormat = "HH:mm"
//                let timeString = dateFormatter.string(from: date)
//                cell.returnDeparturTimeLb.text = timeString
//
//            }
//        }
//    }
//
//    if let returnData = firstOneway.returndata, indexPath.row < returnData.count {
//        if let returnDeparturDate = returnData[indexPath.row].DepartureDateTime {
//            if let returnDeparturDates = returnDeparturDate.first {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//                if let date = dateFormatter.date(from: returnDeparturDates) {
//                    dateFormatter.dateFormat =  "dd MMM, EEE"
//                    let timeString = dateFormatter.string(from: date)
//                    cell.returnDeparturDateLb.text = timeString
//
//                }
//            }
//        }
//    }
//
//    if let returnData = firstOneway.returndata, indexPath.row < returnData.count {
//
//        if let returnArrivalTime = returnData[indexPath.row].ArrivalDateTime {
//            if let returnArrivalTimes = returnArrivalTime.first {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//                if let date = dateFormatter.date(from: returnArrivalTimes) {
//                    dateFormatter.dateFormat = "HH:mm"
//                    let timeString = dateFormatter.string(from: date)
//                    cell.returnArrivalTimeLb.text = timeString
//
//                }
//            }
//        }
//
//
//    }
//
//    if let returnData = firstOneway.returndata, indexPath.row < returnData.count {
//
//        if let returnDeparturDate = returnData[indexPath.row].ArrivalDateTime {
//            if let returnDeparturDates = returnDeparturDate.first {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//                if let date = dateFormatter.date(from: returnDeparturDates) {
//                    dateFormatter.dateFormat = "dd MMM, EEE"
//                    let timeString = dateFormatter.string(from: date)
//                    cell.returnDeparturDateLb.text = timeString
//                }
//            }
//        }
//
//    }
//
//}
//
