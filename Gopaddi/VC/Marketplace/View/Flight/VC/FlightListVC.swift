//
//  FlightListVC.swift
//  Gopaddi
//
//  Created by admin on 01/11/23.
//

import UIKit


protocol Flightsort{
    func sortDetails(sortValue : Int)}

class FlightListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,Flightsort{
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editViewBtn: UIButton!
    @IBOutlet weak var fromNameLb: UILabel!
    @IBOutlet weak var fromDateLb: UILabel!
    @IBOutlet weak var toNameLb: UILabel!
    @IBOutlet weak var toDateLb: UILabel!
    
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortView: UIView!
    
    
    @IBOutlet weak var tableviews: UITableView!
    
    let apiManager = ApiManager()
    var sortID : String?
    var filterDuration : [String]?
    var activityId = String()
    var location = String()
    var dated = String()
    var childCount = String()
    var adultCount = String()
    var childAges = [Int]()
    var userLogin = String()
    
    var fromTFField: String = ""
    var toTFField : String = ""
    var departonTFField: String = ""
    var returnonTFField : String = ""
    var cabinvalueTFField : String = ""
    var adultCountTFField : String = ""
    var childCountTFField: String = ""
    var infantsCountTFField : String = ""
    var tripTypeTFField : String = ""
    var Flightsearch: FlightsearchModel?
    var flightResult: FlightResult?
    var Onewaydat = [Onewaydatas]()
    var departonCodes: String = ""
    var returnonCodes: String = ""
    var departonDateCodes: String = ""
    var returnonDateCodes: String = ""
    let popup = FlightSortVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatess()
    }
    func updatess(){
        disableUserInteraction()
        apicall()
        
        fromNameLb.text = departonCodes
        toNameLb.text = returnonCodes
        fromDateLb.text = departonDateCodes
        toDateLb.text = returnonDateCodes
        
        editView.layer.cornerRadius = 10
        editView.layer.borderWidth = 1
        editView.layer.borderColor = UIColor.gray.cgColor
        
        filterView.layer.cornerRadius = 10
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.gray.cgColor
        
        sortView.layer.cornerRadius = 10
        sortView.layer.borderWidth = 1
        sortView.layer.borderColor = UIColor.gray.cgColor
        
        
        
        
    }
    
    
    
    func apicall(){
        tableviews.showLoading()
        let fromField = fromTFField
        let toField = toTFField
        let departonField = departonTFField
        let returnonField = returnonTFField
        let cabinField = cabinvalueTFField
        let adultCountField = adultCountTFField
        let childCountField = childCountTFField
        let infantsCountField = infantsCountTFField
        let tripTypeField = tripTypeTFField
        ApiManager.shared.flightapisearch(user: "260",
                                          tripType: tripTypeField,
                                          fromCity: fromField,
                                          toCity: toField,
                                          departDate: departonField,
                                          returnDate: returnonField,
                                          adultss: adultCountField,
                                          childss: childCountField,
                                          infants: infantsCountField,
                                          cabinClass: cabinField) { [self] result in
            switch result{
            case.success(let model):
                DispatchQueue.main.async {[weak self] in
                    if model.code == "200" {
                        self?.Flightsearch = model
                        //                               self?.Onewaydat = model.result.
                        print(" Successfulllyokkkkkkk : \(model.result)")
                        
                        
                        
                        self?.tableviews.stopLoading()
                        self?.tableviews.reloadData()
                        self?.enableUserInteractions()
                    }
                    else {
                        let alertcontrollert = UIAlertController(title: "Error" , message: "Something went wrong!", preferredStyle: .alert)
                        let alertButoon = UIAlertAction(title: "Ok", style: .default) { _ in
                            print("Error")
                        }
                        alertcontrollert.addAction(alertButoon)
                        self?.present(alertcontrollert, animated: true)
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //    func sortDetails(sortValue: Int) {
    //        switch sortValue {
    //        case 1:  Onewaydat.sort(by: {$0.TotalFare! < $1.TotalFare!})
    //        case 2:  Onewaydat.sort(by: {$0.TotalFare! > $1.TotalFare!})
    //        default:
    //            print("Invalid")
    //        }
    //        self.tableviews.reloadData()
    //    }
    func sortDetails(sortValue: Int) {
//        if let array = Flightsearch?.result {
//            for index in 0..<array.count {
//                var oneway = array[index].onewaydata
//
//                // Optional handling and ensuring TotalFare isn't nil
//                oneway = oneway.filter { $0.TotalFare != nil }
//
//                if sortValue == 1 {
//                    oneway.sort { ($0.TotalFare ?? 0) < ($1.TotalFare ?? 0) }
//                    Flightsearch?.result[index].onewaydata = oneway
//                    tableviews.reloadData()
//                    print("Sorted in ascending order by TotalFare")
//                } else if sortValue == 2 {
//                    oneway.sort { ($0.TotalFare ?? 0) > ($1.TotalFare ?? 0) }
//                    Flightsearch?.result?[index].onewaydata = oneway
//                    tableviews.reloadData()
//                    print("Sorted in descending order by TotalFare")
//                }
//            }
//        }
    }
//
//
    
    
    
    private func disableUserInteraction() {
        view.isUserInteractionEnabled = false
    }
    private func enableUserInteractions() {
        view.isUserInteractionEnabled = true
    }
    
    @IBAction func bachBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func editViewbtn(_ sender: Any) {
    }
    
    @IBAction func filterBtn(_ sender: Any) {
    }
    
    @IBAction func sortBtn(_ sender: Any) {
        
        
        let  FlightSortVCPopup = self.storyboard?.instantiateViewController(withIdentifier: "FlightSortVC") as? FlightSortVC
        FlightSortVCPopup?.delegate = self
        
        present(FlightSortVCPopup!, animated: true, completion: nil)
        
        self.popup.appear(sender: self)
        
        
        let vc = FlightSortVC()
        let navVC = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(navVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Flightsearch?.result.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FlightListTableCell else {
            return UITableViewCell()
        }
        
        if let flightResult = Flightsearch?.result[indexPath.row] {
            // Assuming "OperatingAirline_Text" is an array of strings
            if let firstOneway = flightResult.onewaydata.first {
                // Join the array of strings into a single string
                
                
                
                if let airlineName = firstOneway.OperatingAirline_Text?.first {
                    cell.flightNameLb.text = airlineName
                }

                
                
                if let stopsValue = firstOneway.Stops {
                    if stopsValue == 1 {
                        cell.stopsLb.text = "nonstop"
                    } else{
                        cell.stopsLb.text = "\(stopsValue) stops"
                    }
                }
                
                if let oneWayTravelingTime = firstOneway.Total_Duration {
                    let hours = oneWayTravelingTime / 60  // Convert minutes to hours
                    let minutes = oneWayTravelingTime % 60  // Remaining minutes after converting to hours
                    
                    cell.oneWayTravelingTimeLb.text = String(format: "%d h %d m", hours)
                }
                
                
                if let totalFare = firstOneway.TotalFare, let currencyCode = firstOneway.CurrencyCode {
                    print("totalFare:\(totalFare)")
                    
                    let roundedTotalFare = Int(totalFare.rounded()) // Round the TotalFare to the nearest integer
                    cell.totalPriceLb.text = "\(roundedTotalFare) \(currencyCode)"
                }
                
                if let operatingAirlineCode = firstOneway.OperatingAirline_Code,
                   let airlineFlightNumber = firstOneway.OperatingAirline_FlightNumber {
                    
                    if operatingAirlineCode.indices.contains(1), airlineFlightNumber.indices.contains(1) {
                        if let firstAirline = operatingAirlineCode.first, let flightNum = airlineFlightNumber.first {
                            let secondAirline = operatingAirlineCode[1]
                            let secondFlightNum = airlineFlightNumber[1]
                            
                            let thirdAirline = operatingAirlineCode.indices.contains(2) ? operatingAirlineCode[2] : nil
                            let thirdFlightNum = airlineFlightNumber.indices.contains(2) ? airlineFlightNumber[2] : nil
                            
                            let firstPart = "\(firstAirline)-\(flightNum)"
                            let secondPart = "\(secondAirline)-\(secondFlightNum)"
                            let thirdPart = thirdAirline != nil && thirdFlightNum != nil ? "\(thirdAirline!)-\(thirdFlightNum!)" : ""
                            
                            cell.flightCodeLb.text = "\(firstPart) \(secondPart) \(thirdPart)"
                            
                        }
                    }
                }
                
                if let operatingAirlineImage = firstOneway.OperatingAirline_Image,
                   let AirlineImage = operatingAirlineImage.first,
                   let imageURL = URL(string: AirlineImage) {
                    // Assuming cell.coutryImage is a UIImageView
                    cell.coutryImage.sd_setImage(with: imageURL, completed: nil)
                }
                
                if let departureTimes = firstOneway.DepartureDateTime {
                    if let firstDepartureTime = departureTimes.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: firstDepartureTime) {
                            dateFormatter.dateFormat = "HH:mm"
                            let timeString = dateFormatter.string(from: date)
                            cell.oneWayDeparturTimeLb.text = timeString
                            
                            
                        }
                    }
                }
                
                if let oneWayDeparturDate = firstOneway.DepartureDateTime {
                    if let oneWayDeparturDates = oneWayDeparturDate.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: oneWayDeparturDates) {
                            dateFormatter.dateFormat = "dd MMM, EEE"
                            let timeString = dateFormatter.string(from: date)
                            cell.oneWayDeparturDateLb.text = timeString
                            
                            
                        }
                    }
                }
                if let arrivalTime = firstOneway.ArrivalDateTime {
                    if let arrivalTimes = arrivalTime.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: arrivalTimes) {
                            dateFormatter.dateFormat = "HH:mm"
                            let timeString = dateFormatter.string(from: date)
                            cell.oneWayArrivalTimeLb.text = timeString
                            
                            
                        }
                    }
                }
                
                
                if let oneWayArrivalDate = firstOneway.ArrivalDateTime {
                    if let oneWayArrivalDates = oneWayArrivalDate.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: oneWayArrivalDates) {
                            dateFormatter.dateFormat = "dd MMM, EEE"
                            let timeString = dateFormatter.string(from: date)
                            cell.oneWayArrivalDateLb.text = timeString
                            
                        }
                    }
                }
                
                
            }//firstOneway end
            
        }//flightResult end
        
        if tripTypeTFField == "R" {
            if let flightResult2 = Flightsearch?.result[indexPath.row] {
                let onewayData = flightResult2.onewaydata
                for oneway in onewayData {
                    if let returnData = oneway.returndata {
                        for returnFlight in returnData {
                            // Access properties of the returnFlight object here
                            // Example:
                            // Set the return flight departure time
                            
                            if let stopsValue = returnFlight.Stops {
                                if stopsValue == 1 {
                                    cell.returnStopsLb.text = "nonstop"
                                } else{
                                    cell.returnStopsLb.text = "\(stopsValue) stops"
                                }
                            }
                            
                            if let returnDepartureTimes = returnFlight.DepartureDateTime {
                                if let returnDepartureTime = returnDepartureTimes.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnDepartureTime) {
                                        dateFormatter.dateFormat = "HH:mm"
                                        let timeString = dateFormatter.string(from: date)
                                        cell.returnDeparturTimeLb.text = timeString
                                    }
                                }
                            }
                            
                            
                            if let returnTravelingTime = returnFlight.Total_Duration {
                                let hours = returnTravelingTime / 60  // Convert minutes to hours
                                let minutes = returnTravelingTime % 60  // Remaining minutes after converting to hours
                                cell.returnTravelingTimeLb.text = String(format: "%d h %d m", hours)
                            }
                            
                            if let returnDepartureDate = returnFlight.DepartureDateTime {
                                if let returnDepartureDates = returnDepartureDate.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnDepartureDates) {
                                        dateFormatter.dateFormat = "dd MMM, EEE"
                                        let timeString = dateFormatter.string(from: date)
                                        cell.returnDeparturDateLb.text = timeString
                                    }
                                }
                            }
                            
                            if let returnArrivalTime = returnFlight.ArrivalDateTime {
                                if let returnArrivalTimes = returnArrivalTime.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnArrivalTimes) {
                                        dateFormatter.dateFormat = "HH:mm"
                                        let timeString = dateFormatter.string(from: date)
                                        cell.returnArrivalTimeLb.text = timeString
                                    }
                                }
                            }
                            
                            
                            if let returnArrivalDate = returnFlight.DepartureDateTime {
                                if let returnArrivalDates = returnArrivalDate.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnArrivalDates) {
                                        dateFormatter.dateFormat = "dd MMM, EEE"
                                        let timeString = dateFormatter.string(from: date)
                                        cell.returnArrivalDateLb.text = timeString
                                    }
                                }
                            }
                   
                            // Process other return flight data here
                        }
                    }
                }
            }
        } else {
            cell.returnView.isHidden = true
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Assuming you have a FlightDetailsVC instantiated from the storyboard with an identifier "FlightDetailsVC"
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FlightDetailsVC") as? FlightDetailsVC else {
            return
        }
        vc.travelFromToVC = ("\(departonCodes) - \(returnonCodes)")
        vc.tripTypeMoodVC = tripTypeTFField
        // Assuming the data you want to pass is available in your FlightsearchModel or FlightResult.
        if let selectedFlight = Flightsearch?.result[indexPath.row] {
            
            if let firstOneway = selectedFlight.onewaydata.first {
                
                if let airlineName = firstOneway.OperatingAirline_Text?.first {
                    vc.airlineNameVC = airlineName
                }
          
                if let baggageInfo = firstOneway.BaggageInformation {
                    for baggage in baggageInfo {
                        if let pieces = baggage.first?.Pieces {
                            print("Number of pieces: \(pieces)")
                            let piecesString = String(pieces)
                            vc.baggageVC = ("Baggage \(piecesString) Pieces per passenger")
                            vc.baggageInfoVC = ("Pieces: \(piecesString)")
                        } else if let weight = baggage.first?.Weight, let unit = baggage.first?.Unit {
                            print("Number of weight: \(weight)")
                            let weightString = String(weight)
                            let unitString = String(unit)
                            vc.baggageVC = ("Baggage \(weightString) \(unitString) per passenger")
                            vc.baggageInfoVC = ("Wegight: \(weightString) \(unitString)")
                        } else {
                            // Handle the scenario where both Pieces and Weight/Unit are not available
                            print("No baggage information available")
                            // Set a default value or handle the absence of baggage information here
                            vc.baggageVC = "No baggage information available"
                        }
                    }
                } else {
                    // Handle the scenario where BaggageInformation doesn't exist
                    print("No baggage information available")
                    // Set a default value or handle the absence of baggage information here
                    vc.baggageVC = "No baggage information available"
                }
                if let oneWayTravelingTime = firstOneway.Total_Duration {
                    let hours = oneWayTravelingTime / 60  // Convert minutes to hours
                    let minutes = oneWayTravelingTime % 60  // Remaining minutes after converting to hours
                    let travelTime = String(format: "%d h %d m", hours,minutes)
                    vc.travelTimeVC = "Travel time: \(travelTime)"
                }
                
                if let operatingAirlineImage = firstOneway.OperatingAirline_Image,
                   let AirlineImage = operatingAirlineImage.first,
                   let imageURL = URL(string: AirlineImage) {
                 
                    // After setting the image to the UIImageView, you might assign it to the vc.airlineImageVC
                    vc.imageURL = imageURL
                }
                
                
                if let operatingAirlineCode = firstOneway.OperatingAirline_Code,
                   let airlineFlightNumber = firstOneway.OperatingAirline_FlightNumber {
                    
                    if operatingAirlineCode.indices.contains(1), airlineFlightNumber.indices.contains(1) {
                        if let firstAirline = operatingAirlineCode.first, let flightNum = airlineFlightNumber.first {
                            let secondAirline = operatingAirlineCode[1]
                            let secondFlightNum = airlineFlightNumber[1]
                            
                            let thirdAirline = operatingAirlineCode.indices.contains(2) ? operatingAirlineCode[2] : nil
                            let thirdFlightNum = airlineFlightNumber.indices.contains(2) ? airlineFlightNumber[2] : nil
                            
                            let firstPart = "\(firstAirline)-\(flightNum)"
                            let secondPart = "\(secondAirline)-\(secondFlightNum)"
                            let thirdPart = thirdAirline != nil && thirdFlightNum != nil ? "\(thirdAirline!)-\(thirdFlightNum!)" : ""
                            
                            vc.airlinCodeVC = "\(firstPart) \(secondPart) \(thirdPart)"

                        }
                    }
                }
                
                if let totalFare = firstOneway.TotalFare, let currencyCode = firstOneway.CurrencyCode {
                    print("totalFare:\(totalFare)")
                    
                    let roundedTotalFare = Int(totalFare.rounded()) // Round the TotalFare to the nearest integer
                    vc.totalPriceVC  = "\(roundedTotalFare) \(currencyCode)"
                }
                
                if let oneWayDeparturTime = firstOneway.DepartureDateTime {
                    if let firstDepartureTime = oneWayDeparturTime.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        if let date = dateFormatter.date(from: firstDepartureTime) {
                            dateFormatter.dateFormat = "HH:mm"
                            let timeString = dateFormatter.string(from: date)
                            vc.oneWayDeparturTimeVC = timeString
                        }
                    }
                }
                
                if let oneWayDeparturDate = firstOneway.DepartureDateTime {
                    if let oneWayDeparturDates = oneWayDeparturDate.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: oneWayDeparturDates) {
                            dateFormatter.dateFormat = "dd MMM, EEE"
                            let timeString = dateFormatter.string(from: date)
                            vc.oneWayDeparturDateVC = timeString
                            
                            
                        }
                    }
                }
                if let oneWyarrivalTime = firstOneway.ArrivalDateTime {
                    if let oneWyarrivalTimes = oneWyarrivalTime.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: oneWyarrivalTimes) {
                            dateFormatter.dateFormat = "HH:mm"
                            let timeString = dateFormatter.string(from: date)
                            vc.oneWayArrivalTimeVC = timeString
                            
                            
                        }
                    }
                }
                
                
                if let oneWayArrivalDate = firstOneway.ArrivalDateTime {
                    if let oneWayArrivalDates = oneWayArrivalDate.first {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        if let date = dateFormatter.date(from: oneWayArrivalDates) {
                            dateFormatter.dateFormat = "dd MMM, EEE"
                            let timeString = dateFormatter.string(from: date)
                            vc.oneWayArrivalDateVC = timeString
                            
                        }
                    }
                }
                
                if let stopsValue = firstOneway.Stops {
                    if stopsValue == 1 {
                        vc.onWayStopesVC = "nonstop"
                    } else{
                        vc.onWayStopesVC = "\(stopsValue) stops"
                    }
                }
                
                if let oneWayTravelingTime = firstOneway.Total_Duration {
                    let hours = oneWayTravelingTime / 60  // Convert minutes to hours
                    let minutes = oneWayTravelingTime % 60  // Remaining minutes after converting to hours
                    let travelTime = String(format: "%d h %d m", hours)
                    vc.onWayTravelDurationVC = travelTime
                }
                
                if let departureLocationText = firstOneway.Departure_LocationText {
                    // Create a new array to store elements from DepartureLocationText
                    var newArray: [String] = []
                    
                    for text in departureLocationText {
                        newArray.append(text) // Append the entire 'text' to 'newArray'
                    }
                    
                    // Pass newArray to vc
                    vc.departureLocationTextArray = newArray
                }

                 if let arrivalLocationText = firstOneway.Arrival_LocationText {
                    // Create a new array to store elements from DepartureLocationText
                    var newArray: [String] = []
                    
                    for text in arrivalLocationText {
                        newArray.append(text) // Append the entire 'text' to 'newArray'
                    }
                    
                    // Pass newArray to vc
                    vc.arrivalLocationTextArray = newArray
                }
                
                if let departureTimes = firstOneway.DepartureDateTime {
                    var departureTimeArray: [String] = []
                    
                    for text in departureTimes {
                        departureTimeArray.append(text)
                    }
                    print(departureTimes)
                    vc.departureTimeArrayas = departureTimeArray
                }

                if let arrivalTime = firstOneway.ArrivalDateTime {
                    // Create an array to store processed departure times
                    var arrivalTimeArray: [String] = []
                    
                    for text in arrivalTime {
                        arrivalTimeArray.append(text)
                    }
                    print(arrivalTimeArray)
                    vc.ArrivalTimeArrayas = arrivalTimeArray
                }
                
                if let operatingAirlineCodes = firstOneway.OperatingAirline_Code{
                    
                    var operatingAirlineCodesArray: [String] = []
                    
                    for text in operatingAirlineCodes {
                        operatingAirlineCodesArray.append(text)
                    }
                    vc.operatingAirlineCodesArrays = operatingAirlineCodesArray
                    
                }
                if let AirlineFlightNumber = firstOneway.OperatingAirline_FlightNumber {
                    
                    var AirlineFlightNumberArray: [String] = []
                    
                    for text in AirlineFlightNumber {
                        AirlineFlightNumberArray.append(text)
                    }
                    vc.AirlineFlightNumberArrays = AirlineFlightNumberArray
                }
                
                if let CabinTextt = firstOneway.Cabin_Text {
                    
                    var CabinTextArray: [String] = []
                    
                    for text in CabinTextt {
                        CabinTextArray.append(text)
                    }
                    vc.CabinTextArrays = CabinTextArray
                }
                
                if let AirEquipText = firstOneway.AirEquipType {
                    
                    var newArray: [String] = []
                    
                    for text in AirEquipText {
                        newArray.append(text)
                    }
                    vc.AirEquipTypeArrays = newArray
                }
                
                
                if let DepartuLocatiCode = firstOneway.Departure_LocationCode {
                    
                    var newArray: [String] = []
                    
                    for text in DepartuLocatiCode {
                        newArray.append(text)
                    }
                    vc.DepartuLocatiCodeArrays = newArray
                }

                if let ArrivalLocatiCode = firstOneway.Arrival_LocationCode {
                    
                    var newArray: [String] = []
                    
                    for text in ArrivalLocatiCode {
                        newArray.append(text)
                    }
                    vc.arrivalLocatiCodeArrays = newArray
                }


            }//firstOnewayend
            
        }//selectedFlightend
        
        if tripTypeTFField == "R" {
            if let flightResult2 = Flightsearch?.result[indexPath.row] {
                let onewayData = flightResult2.onewaydata
                for oneway in onewayData {
                    if let returnData = oneway.returndata {
                        for returnFlight in returnData {
                            // Access properties of the returnFlight object here
                            // Example:
                            // Set the return flight departure time
                            
                            if let stopsValue = returnFlight.Stops {
                                if stopsValue == 1 {
                                    vc.returnStopesVC = "nonstop"
                                } else{
                                    vc.returnStopesVC = "\(stopsValue) stops"
                                }
                            }
                            
                            if let returnDepartureTimes = returnFlight.DepartureDateTime {
                                if let returnDepartureTime = returnDepartureTimes.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnDepartureTime) {
                                        dateFormatter.dateFormat = "HH:mm"
                                        let timeString = dateFormatter.string(from: date)
                                        vc.returnDeparturTimeVC = timeString
                                    }
                                }
                            }
                            
                            
                            if let returnTravelingTime = returnFlight.Total_Duration {
                                let hours = returnTravelingTime / 60  // Convert minutes to hours
                                let minutes = returnTravelingTime % 60  // Remaining minutes after converting to hours
                                vc.returnTravelDurationVC = String(format: "%d h %d m", hours)
                            }
                            
                            if let returnDepartureDate = returnFlight.DepartureDateTime {
                                if let returnDepartureDates = returnDepartureDate.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnDepartureDates) {
                                        dateFormatter.dateFormat = "dd MMM, EEE"
                                        let timeString = dateFormatter.string(from: date)
                                        vc.returnDeparturDateVC = timeString
                                    }
                                }
                            }
                            
                            if let returnArrivalTime = returnFlight.ArrivalDateTime {
                                if let returnArrivalTimes = returnArrivalTime.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnArrivalTimes) {
                                        dateFormatter.dateFormat = "HH:mm"
                                        let timeString = dateFormatter.string(from: date)
                                        vc.returnArrivalTimeVC = timeString
                                    }
                                }
                            }
                            
                            
                            if let returnArrivalDate = returnFlight.DepartureDateTime {
                                if let returnArrivalDates = returnArrivalDate.first {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    if let date = dateFormatter.date(from: returnArrivalDates) {
                                        dateFormatter.dateFormat = "dd MMM, EEE"
                                        let timeString = dateFormatter.string(from: date)
                                        vc.returnArrivalDateVC = timeString
                                    }
                                }
                            }
                            
                            if let returndepartureLocationText = returnFlight.Departure_LocationText {
                                // Create a new array to store elements from DepartureLocationText
                                var newArray: [String] = []
                                
                                for text in returndepartureLocationText {
                                    newArray.append(text) // Append the entire 'text' to 'newArray'
                                }
                                
                                // Pass newArray to vc
                                vc.returndepartureLocationTextArray = newArray
                            }
                            if let returnarrivalLocationText = returnFlight.Arrival_LocationText {
                               // Create a new array to store elements from DepartureLocationText
                               var newArray: [String] = []
                               
                               for text in returnarrivalLocationText {
                                   newArray.append(text) // Append the entire 'text' to 'newArray'
                               }
                               
                               // Pass newArray to vc
                               vc.returnarrivalLocationTextArray = newArray
                           }
                           
                           if let returndepartureTimes = returnFlight.DepartureDateTime {
                               var newArray: [String] = []
                               
                               for text in returndepartureTimes {
                                   newArray.append(text)
                               }
                               vc.returndepartureTimeArrayas = newArray
                           }

                           if let returnarrivalTime = returnFlight.ArrivalDateTime {
                               // Create an array to store processed departure times
                               var newArray: [String] = []
                               
                               for text in returnarrivalTime {
                                   newArray.append(text)
                               }
                               vc.returnArrivalTimeArrayas = newArray
                           }
                           
                           if let returnoperatingAirlineCodes = returnFlight.OperatingAirline_Code{
                               
                               var newArray: [String] = []
                               
                               for text in returnoperatingAirlineCodes {
                                   newArray.append(text)
                               }
                               vc.returnoperatingAirlineCodesArrays = newArray
                               
                           }
                           if let AirlineFlightNumber = returnFlight.OperatingAirline_FlightNumber {
                               
                               var newArray: [String] = []
                               
                               for text in AirlineFlightNumber {
                                   newArray.append(text)
                               }
                               vc.returnAirlineFlightNumberArrays = newArray
                           }
                           
                            if let CabinTextt = returnFlight.Cabin_Text {
                               
                               var newArray: [String] = []
                               
                               for text in CabinTextt {
                                   newArray.append(text)
                               }
                               vc.returnCabinTextArrays = newArray
                           }
                            
                            if let AirEquipText = returnFlight.AirEquipType {
                                
                                var newArray: [String] = []
                                
                                for text in AirEquipText {
                                    newArray.append(text)
                                }
                                vc.returnAirEquipTypeArrays = newArray
                            }
  
                            
                            if let DepartuLocatiCode = returnFlight.Departure_LocationCode {
                                
                                var newArray: [String] = []
                                
                                for text in DepartuLocatiCode {
                                    newArray.append(text)
                                }
                                vc.returnDepartuLocatiCodeArrays = newArray
                            }
  
                            if let ArrivalLocatiCode = returnFlight.Arrival_LocationCode {
                                
                                var newArray: [String] = []
                                
                                for text in ArrivalLocatiCode {
                                    newArray.append(text)
                                }
                                vc.returnarrivalLocatiCodeArrays = newArray
                            }
 
                        }//end returnFlight
                    }
                }
            }
        } else {
            vc.returnViewVC = true
        }
        
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tripTypeTFField == "R" {
            return 197
        } else {
            return 160
        }
    }
}




//                if let baggageInfo = firstOneway.BaggageInformation {
//                    for baggage in baggageInfo {
//                        if let pieces = baggage.first?.Pieces {
//                            print("Number of pieces: \(pieces)")
//                            let piecesString = String(pieces)
//                            vc.baggageVC = ("Baggage\(piecesString)Pieces per passenger")
//                        }
//                        if let weight = baggage.first?.Weight, let Unit = baggage.first?.Unit {
//                            print("Number of weight: \(weight)")
//                            let weightString = String(weight)
//                            let UnitsString = String(Unit)
//                            vc.baggageVC = ("Baggage\(weightString)\(UnitsString)Pieces per passenger")
//
//                        }
//                    }
//                }
      
                
