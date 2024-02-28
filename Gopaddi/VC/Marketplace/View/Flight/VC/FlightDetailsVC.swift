//
//  FlightDetailsVC.swift
//  Gopaddi
//
//  Created by admin on 07/11/23.
//

import UIKit

class FlightDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    @IBOutlet weak var baggageMainView: UIView!
    @IBOutlet weak var flightTimeView: UIView!
    @IBOutlet weak var flightView1: UIView!
    @IBOutlet weak var flightView2: UIView!
    @IBOutlet weak var fareView: UIView!
    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var flightView3: UIView!
    @IBOutlet weak var flightView4: UIView!
    @IBOutlet weak var flightView5: UIView!
    @IBOutlet weak var flightView6: UIView!
    @IBOutlet weak var baggageRulesTF: UITextField!
    @IBOutlet weak var fromToLb: UILabel!
    
    @IBOutlet weak var totalTraveltimeLb: UILabel!
    @IBOutlet weak var coutryImage: UIImageView!
    @IBOutlet weak var flightNameLB: UILabel!
    @IBOutlet weak var flightCodeLb: UILabel!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var totalPriceLb: UILabel!
    
    @IBOutlet weak var oneWayDeparturTimeLb: UILabel!
    @IBOutlet weak var oneWayDeparturDateLb: UILabel!
    @IBOutlet weak var oneWayArrivalTimeLb: UILabel!
    @IBOutlet weak var oneWayArrivalDateLb: UILabel!
    @IBOutlet weak var oneWayTravelingTimeLb: UILabel!
    @IBOutlet weak var stopsLb: UILabel!
    
    @IBOutlet weak var returnDeparturTimeLb: UILabel!
    @IBOutlet weak var returnDeparturDateLb: UILabel!
    @IBOutlet weak var returnArrivalTimeLb: UILabel!
    @IBOutlet weak var returnArrivalDateLb: UILabel!
    @IBOutlet weak var returnTravelingTimeLb: UILabel!
    @IBOutlet weak var returnStopsLb: UILabel!
    @IBOutlet weak var mainViewLayout: NSLayoutConstraint!
    
    @IBOutlet weak var fareBreakupLb: UILabel!
    
    @IBOutlet weak var flightLtineraryLayoutView: NSLayoutConstraint!
    
    @IBOutlet weak var tableviews: UITableView!
    
    @IBOutlet weak var tableviews2: UITableView!
    
    
    @IBOutlet weak var fareRuleTableview: UITableView!
    
    @IBOutlet weak var fareRuleTableview2: UITableView!
    
    
    @IBOutlet weak var baggageTableview: UITableView!
    
    @IBOutlet weak var baggageTableview2: UITableView!
    
    
    
    @IBOutlet weak var flyltineryLayout: NSLayoutConstraint!
    
    @IBOutlet weak var flyltinerytableLayout: NSLayoutConstraint!
    
    var baggageVC = String()
    var travelFromToVC = String()
    var travelTimeVC = String()
    var imageURL: URL?
    var airlineNameVC = String()
    var airlinCodeVC = String()
    var totalPriceVC = String()
    var oneWayDeparturTimeVC = String()
    var oneWayDeparturDateVC = String()
    var oneWayArrivalTimeVC = String()
    var oneWayArrivalDateVC = String()
    var returnDeparturTimeVC = String()
    var returnDeparturDateVC = String()
    var returnArrivalTimeVC = String()
    var returnArrivalDateVC = String()
    var onWayStopesVC = String()
    var returnStopesVC = String()
    var onWayTravelDurationVC = String()
    var returnTravelDurationVC  = String()
    var returnViewVC  = Bool()
    var tripTypeMoodVC  = String()
    
    var baggageInfoVC  = String()
    var baggageInfoVC2  = String()
    
    
    var flightDeparturPlace1 = String()
    var flightDeparturPlace2 = String()
    var flightDeparturPlace3 = String()
    var flightDeparturPlace4 = String()
    var flightDeparturPlace5 = String()
    var flightDeparturPlace6 = String()
    
    var flightDeparturDateTime1 = String()
    var flightDeparturDateTime2 = String()
    var flightDeparturDateTime3 = String()
    var flightDeparturDateTime4 = String()
    var flightDeparturDateTime5 = String()
    var flightDeparturDateTime6 = String()
    
    var flightDeparturAirlincodeNumberCabin1 = String()
    var flightDeparturAirlincodeNumberCabin2 = String()
    var flightDeparturAirlincodeNumberCabin3 = String()
    var flightDeparturAirlincodeNumberCabin4 = String()
    var flightDeparturAirlincodeNumberCabin5 = String()
    var flightDeparturAirlincodeNumberCabin6 = String()
    
    var airlinCodeDeparture0 = String()
    var airlinCodeArrival0 = String()
    
    var departureLocationTextArray: [String] = []
    var arrivalLocationTextArray  : [String] = []
    
    var departureTimeArrayas  : [String] = []
    var ArrivalTimeArrayas  : [String] = []
    
    var operatingAirlineCodesArrays  : [String] = []
    var AirlineFlightNumberArrays  : [String] = []
    
    var CabinTextArrays  : [String] = []
    
    
    var returndepartureLocationTextArray: [String] = []
    var returnarrivalLocationTextArray  : [String] = []
    
    var returndepartureTimeArrayas  : [String] = []
    var returnArrivalTimeArrayas  : [String] = []
    
    var returnoperatingAirlineCodesArrays  : [String] = []
    var returnAirlineFlightNumberArrays  : [String] = []
    var returnCabinTextArrays  : [String] = []
    
    var AirEquipTypeArrays  : [String] = []
    var returnAirEquipTypeArrays  : [String] = []
    
    var returnDepartuLocatiCodeArrays  : [String] = []
    var returnarrivalLocatiCodeArrays  : [String] = []
    
    var DepartuLocatiCodeArrays  : [String] = []
    var arrivalLocatiCodeArrays  : [String] = []

  
    override func viewDidLoad() {
        super.viewDidLoad()
        flyltineryLayoutUpdate()
        flyltineryLayoutUpdate2()

        editViews()
        textUpdates()
    }
    
    func flyltineryLayoutUpdate(){
        if departureLocationTextArray.count == 1 {
            flyltineryLayout.constant = 150
        }else if departureLocationTextArray.count == 2{
            flyltineryLayout.constant = 300
        }else{
            flyltineryLayout.constant = 450
        }
        
        if departureLocationTextArray.count == 2 {
             flyltinerytableLayout.constant = 300
         } else if departureLocationTextArray.count == 3 {
             flyltinerytableLayout.constant = 450
         }else{
             flyltinerytableLayout.constant = 150
         }
    }
    func flyltineryLayoutUpdate2() {
      
    }

    
    
    
    func applyStyles(to view: UIView) {
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
    }
    
    func editViews() {
//        applyStyles(to: baggageMainView)
//        applyStyles(to: flightTimeView)
        applyStyles(to: fareView)
//        applyStyles(to: rulesView)
//        applyStyles(to: informationView)
        
        buyBtn.layer.cornerRadius = 10
        buyBtn.layer.shadowOpacity = 0.1
        buyBtn.layer.shadowRadius = 10
    }
    
    func textUpdates() {
        baggageRulesTF.text = baggageVC
        fromToLb.text = travelFromToVC
        totalTraveltimeLb.text = travelTimeVC
        flightNameLB.text = airlineNameVC
        flightCodeLb.text = airlinCodeVC
        totalPriceLb.text = totalPriceVC
        oneWayDeparturTimeLb.text = oneWayDeparturTimeVC
        oneWayDeparturDateLb.text = oneWayDeparturDateVC
        oneWayArrivalTimeLb.text = oneWayArrivalTimeVC
        oneWayArrivalDateLb.text = oneWayArrivalDateVC
        oneWayTravelingTimeLb.text = onWayTravelDurationVC
        stopsLb.text = onWayStopesVC
        fareBreakupLb.text = totalPriceVC
        if let imageURL = imageURL {
            coutryImage.sd_setImage(with: imageURL, completed: nil)
        }
        if tripTypeMoodVC == "R"{
            returnDeparturTimeLb.text = returnDeparturTimeVC
            returnDeparturDateLb.text = returnDeparturDateVC
            returnArrivalTimeLb.text = returnArrivalTimeVC
            returnArrivalDateLb.text = returnArrivalDateVC
            returnTravelingTimeLb.text = returnTravelDurationVC
            returnStopsLb.text = returnStopesVC
        }else{
            returnView.isHidden = true
            mainViewLayout.constant = 130
        }
        
        
    }
    @IBAction func buyBtn(_ sender: Any) {
    }
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func fixTextvalue(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableviews {
            return departureLocationTextArray.count
        } else if tableView == tableviews2 {
            return returndepartureLocationTextArray.count
        }else if tableView ==  fareRuleTableview{
            return  returnAirEquipTypeArrays.count
        }else if tableView == fareRuleTableview2 {
            return  AirEquipTypeArrays.count

        }else if tableView == baggageTableview{
            return DepartuLocatiCodeArrays.count

        }else if tableView == baggageTableview2{
            return returnDepartuLocatiCodeArrays.count

        }
           return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableviews2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as? FlightItineraryTableCell2 else {
                return UITableViewCell()
            }
            if indexPath.row < returndepartureLocationTextArray.count {
                cell.flyDerpatureplace1.text = returndepartureLocationTextArray[indexPath.row]
            }

            if indexPath.row < returnarrivalLocationTextArray.count {
                cell.flyArrivalplace1.text = returnarrivalLocationTextArray[indexPath.row]
            }

            if indexPath.row < returndepartureTimeArrayas.count {
                let departureTime = returndepartureTimeArrayas[indexPath.row]

                // Formatter for the original date string
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

                if let date = dateFormatter.date(from: departureTime) {
                    // Formatter for the time display
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm a"
                    let timeString = timeFormatter.string(from: date)

                    // Formatter for the date display
                    let dateStringFormatter = DateFormatter()
                    dateStringFormatter.dateFormat = "dd MMM, EEE"
                    let dateString = dateStringFormatter.string(from: date)

                    // Combine time and date into a single string
                    let dateTimeString = "\(dateString) ; \(timeString)"

                    cell.flyDerpaturAircodeCabin3.text = dateTimeString
                }
            }



            if indexPath.row < returnArrivalTimeArrayas.count {
                let arrivalTime = returnArrivalTimeArrayas[indexPath.row]
                
                // Formatter for the original date string
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                
                if let date = dateFormatter.date(from: arrivalTime) {
                    // Formatter for the time display
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm a"
                    let timeString = timeFormatter.string(from: date)

                    // Formatter for the date display
                    let dateStringFormatter = DateFormatter()
                    dateStringFormatter.dateFormat = "dd MMM, EEE"
                    let dateString = dateStringFormatter.string(from: date)

                    // Combine time and date into a single string
                    let dateTimeString = "\(dateString) ; \(timeString)"

                    cell.flyArrivalAircodeCabin3.text = dateTimeString
                }

            }
            
            if indexPath.row < returnoperatingAirlineCodesArrays.count && indexPath.row < returnAirlineFlightNumberArrays.count && indexPath.row < returnCabinTextArrays.count {
                
                let Code = returnoperatingAirlineCodesArrays[indexPath.row]
                let Number = returnAirlineFlightNumberArrays[indexPath.row]
                let Cabin = CabinTextArrays[indexPath.row]
                cell.flycodeTimeDepatur2.text = ("\(Code) - \(Number) (\(Cabin))")
                cell.flycodeTimeArrivel2.text = ("\(Code) - \(Number) (\(Cabin))")
            }
            
            return cell

            
           } else if tableView == tableviews{
               
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FlightItineraryTableCell else {
                   return UITableViewCell()
               }
               if indexPath.row < departureLocationTextArray.count {
                   cell.flyltineryDerpatureplace1.text = departureLocationTextArray[indexPath.row]
               }

               if indexPath.row < arrivalLocationTextArray.count {
                   cell.flyltineryArrivalplace1.text = arrivalLocationTextArray[indexPath.row]
               }

               if indexPath.row < departureTimeArrayas.count {
                   let departureTime = departureTimeArrayas[indexPath.row]

                   // Formatter for the original date string
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

                   if let date = dateFormatter.date(from: departureTime) {
                       // Formatter for the time display
                       let timeFormatter = DateFormatter()
                       timeFormatter.dateFormat = "HH:mm a"
                       let timeString = timeFormatter.string(from: date)

                       // Formatter for the date display
                       let dateStringFormatter = DateFormatter()
                       dateStringFormatter.dateFormat = "dd MMM, EEE"
                       let dateString = dateStringFormatter.string(from: date)

                       // Combine time and date into a single string
                       let dateTimeString = "\(dateString) ; \(timeString)"

                       cell.flyltineryDerpatureDateTime2.text = dateTimeString
                   }
               }



               if indexPath.row < ArrivalTimeArrayas.count {
                   let arrivalTime = ArrivalTimeArrayas[indexPath.row]
                   
                   // Formatter for the original date string
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                   
                   
                   if let date = dateFormatter.date(from: arrivalTime) {
                       // Formatter for the time display
                       let timeFormatter = DateFormatter()
                       timeFormatter.dateFormat = "HH:mm a"
                       let timeString = timeFormatter.string(from: date)

                       // Formatter for the date display
                       let dateStringFormatter = DateFormatter()
                       dateStringFormatter.dateFormat = "dd MMM, EEE"
                       let dateString = dateStringFormatter.string(from: date)

                       // Combine time and date into a single string
                       let dateTimeString = "\(dateString) ; \(timeString)"

                       cell.flyltineryArrivalDateTime2.text = dateTimeString
                   }

               }
               
               if indexPath.row < operatingAirlineCodesArrays.count && indexPath.row < AirlineFlightNumberArrays.count && indexPath.row < CabinTextArrays.count {
                   
                   let Code = operatingAirlineCodesArrays[indexPath.row]
                   let Number = AirlineFlightNumberArrays[indexPath.row]
                   let Cabin = CabinTextArrays[indexPath.row]
                   cell.flycodeTimeDepatur.text = ("\(Code) - \(Number) (\(Cabin))")
                   cell.flycodeTimeArrivel.text = ("\(Code) - \(Number) (\(Cabin))")
               }
               
               return cell
           }else if tableView ==  fareRuleTableview{
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "FareRuleTableCell", for: indexPath) as? FareRuleTableCell else {
                   return UITableViewCell()
               }
               
               if indexPath.row < operatingAirlineCodesArrays.count && indexPath.row < AirlineFlightNumberArrays.count {
                   let Code = operatingAirlineCodesArrays[indexPath.row]
                   let Number = AirlineFlightNumberArrays[indexPath.row]
                   let Cabin = CabinTextArrays[indexPath.row]
                   cell.airlineLb.text = ("\(Code) - \(Number)")
               }

               
               
               if indexPath.row < returnAirEquipTypeArrays.count {
                   cell.aircraftLb.text = returnAirEquipTypeArrays[indexPath.row]
               }
            
               

               
               return cell

               
           }else if tableView ==  fareRuleTableview2{
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "FareRuleTableCell2", for: indexPath) as? FareRuleTableCell2 else {
                   return UITableViewCell()
               }
          
               if indexPath.row < returnoperatingAirlineCodesArrays.count && indexPath.row < returnAirlineFlightNumberArrays.count {
                   let Code = returnoperatingAirlineCodesArrays[indexPath.row]
                   let Number = returnAirlineFlightNumberArrays[indexPath.row]
                   let Cabin = CabinTextArrays[indexPath.row]
                   cell.airlineLb2.text = ("\(Code) - \(Number)")
               }

               if indexPath.row < returnAirEquipTypeArrays.count {
                   cell.aircraft2Lb.text = returnAirEquipTypeArrays[indexPath.row]
               }

           
               return cell

               
           }else if tableView ==  baggageTableview{
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaggagInfoTableCell", for: indexPath) as? BaggagInfoTableCell else {
                   return UITableViewCell()
               }
               
               if indexPath.row < DepartuLocatiCodeArrays.count {
                   cell.fromLb.text = DepartuLocatiCodeArrays[indexPath.row]
               }
                if indexPath.row < arrivalLocatiCodeArrays.count {
                   cell.toLb.text = arrivalLocatiCodeArrays[indexPath.row]
               }
               cell.weightLb.text = baggageInfoVC
               return cell

           }else if tableView ==  baggageTableview2{
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaggagInfoTableCell2", for: indexPath) as? BaggagInfoTableCell2 else {
                   return UITableViewCell()
               }
               
               if indexPath.row < returnDepartuLocatiCodeArrays.count {
                   cell.fromLb.text = returnDepartuLocatiCodeArrays[indexPath.row]
               }
                if indexPath.row < returnarrivalLocatiCodeArrays.count {
                   cell.toLb.text = returnarrivalLocatiCodeArrays[indexPath.row]
               }
               cell.weightLb2.text = baggageInfoVC
               return cell
               
           }
        
        return UITableViewCell()

        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if tableView == tableviews {
                return 156
            } else if tableView == tableviews2 {
                return 156
            }else if tableView ==  fareRuleTableview{
                return 156

            }else if tableView == fareRuleTableview2 {
                return 156

            }else if tableView == baggageTableview{
                return 156

            }else if tableView == baggageTableview2{
                return 156

            }
        
            return UITableView.automaticDimension
    }
 
}
