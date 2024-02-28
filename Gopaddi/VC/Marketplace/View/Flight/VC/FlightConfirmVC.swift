//
//  FlightConfirmVC.swift
//  Gopaddi
//
//  Created by admin on 25/10/23.
//

import UIKit
protocol PassengerInfo{
    func passengerCount(adultC : String, childC : String ,infantsc:String)
}
class FlightConfirmVC: UIViewController,PassengerInfo,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contectView: UIView!
    @IBOutlet weak var oneWay: UIButton!
    @IBOutlet weak var roundreipBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var roundView1: UIView!
    @IBOutlet weak var roundView2: UIView!
    @IBOutlet weak var roundView3: UIView!
    @IBOutlet weak var roundView4: UIView!
    @IBOutlet weak var roundView5: UIView!
    @IBOutlet weak var roundView6: UIView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var departonTF: UITextField!
    @IBOutlet weak var passengerTF: UITextField!
    @IBOutlet weak var returnonTF: UITextField!
    @IBOutlet weak var cabinTF: UITextField!
    
    @IBOutlet weak var fromTFlayout: NSLayoutConstraint!
    var flightAirportsModel: FlightairportsModel?
    var FlighcabinsModel: FlightcabinsModel?
    var Flightsearch: FlightsearchModel?
    var airportsModel: [Airport]?
    var CabinModel : [Cabin]?
    var childrenAges : [Int]?
    var adultCount : String?
    var childCount : String?
    var infantsCount : String?
    var dateString = String()
    var datePicker = UIDatePicker()
    var datePicker2 = UIDatePicker()
    var checkText = Int()
    var defaultValueForadultCount = "1"
    var defaultValueForChildCount = "0"
    var defaultcabinvalue = "Y"
    var cabinvalues = String()
    var tripMood = String()
    var defaulttripMood = "R"
    var departonCode: String = ""
    var returnonCode: String = ""
    var departonDateCodes: String = ""
    var returnonDateCodes: String = ""
    let defaultValradultCount = "1"

    
    private let tableViewOption: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tag = 1
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editingupdate()
        view.addSubview(tableViewOption)
        //
    }
    func editingupdate() {
        let cornerRadius: CGFloat = 10
        // Apply corner radius and border color to roundView1
        roundView1.layer.cornerRadius = cornerRadius
        roundView1.layer.borderWidth = 1// Set your desired border width
        roundView1.layer.borderColor = UIColor.gray.cgColor // Set your desired border color
        // Repeat the same process for other roundView objects
        roundView2.layer.cornerRadius = cornerRadius
        roundView2.layer.borderWidth = 1
        roundView2.layer.borderColor = UIColor.gray.cgColor
        roundView3.layer.cornerRadius = cornerRadius
        roundView3.layer.borderWidth = 1
        roundView3.layer.borderColor = UIColor.gray.cgColor
        roundView4.layer.cornerRadius = cornerRadius
        roundView4.layer.borderWidth = 1
        roundView4.layer.borderColor = UIColor.gray.cgColor
        roundView5.layer.cornerRadius = cornerRadius
        roundView5.layer.borderWidth = 1
        roundView5.layer.borderColor = UIColor.gray.cgColor
        roundView6.layer.cornerRadius = cornerRadius
        roundView6.layer.borderWidth = 1
        roundView6.layer.borderColor = UIColor.gray.cgColor
        oneWay.layer.cornerRadius = 5
        roundreipBtn.layer.cornerRadius = 5
        oneWay.backgroundColor = #colorLiteral(red: 0.7592689395, green: 0.8149083257, blue: 0.8805872798, alpha: 1)
        roundreipBtn.backgroundColor  = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // Set corner radius and masked corners for other views as well
        submitBtn.layer.cornerRadius = 10
        contectView.layer.cornerRadius = 30
        contectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        fromTF.delegate = self
        toTF.delegate = self
        departonTF.delegate = self
        passengerTF.delegate = self
        returnonTF.delegate = self
        passengerTF.delegate = self
        cabinTF.delegate = self
        
        configurePicker()
        configurePicker2()
    }
    @IBAction func roundreipBtn(_ sender: Any) {
        self.tripMood = "R"
        roundreipBtn.layer.borderColor = #colorLiteral(red: 0.7592689395, green: 0.8149083257, blue: 0.8805872798, alpha: 1)
        roundreipBtn.backgroundColor  = #colorLiteral(red: 0.7592689395, green: 0.8149083257, blue: 0.8805872798, alpha: 1)
        roundreipBtn.titleLabel?.textColor = #colorLiteral(red: 0.1589321792, green: 0.481182456, blue: 0.8787246943, alpha: 1)
        oneWay.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        oneWay.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        oneWay.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        roundView4.isHidden = false
        
    }
    @IBAction func oneWayBtn(_ sender: Any) {
        self.tripMood = "S"
        oneWay.layer.borderColor = #colorLiteral(red: 0.7592689395, green: 0.8149083257, blue: 0.8805872798, alpha: 1)
        oneWay.backgroundColor  = #colorLiteral(red: 0.7592689395, green: 0.8149083257, blue: 0.8805872798, alpha: 1)
        oneWay.titleLabel?.textColor = #colorLiteral(red: 0.1589321792, green: 0.481182456, blue: 0.8787246943, alpha: 1)
        roundreipBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        roundreipBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        roundreipBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        roundView4.isHidden = true
        
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Dismiss the current view controller when the back button is tapped
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // When the return key is pressed, dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    private func configurePicker(){
        let toolBar = UIToolbar()
        let toolBar2 = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        departonTF.inputAccessoryView = toolBar
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        departonTF.inputView = datePicker
    }
    private func configurePicker2(){
        let toolBar = UIToolbar()
        let toolBar2 = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed2))
        toolBar.setItems([doneButton], animated: true)
        returnonTF.inputAccessoryView = toolBar
        datePicker2.preferredDatePickerStyle = .inline
        datePicker2.datePickerMode = .date
        returnonTF.inputView = datePicker2
    }
    
    @objc private func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = datePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        departonTF.text = formattedDate
        departonTF.resignFirstResponder()
        self.view.endEditing(true) // Use true to dismiss the keyboard
        
    }
    
    @objc private func donePressed2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = datePicker2.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        returnonTF.text = formattedDate
        returnonTF.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func passengerCount(adultC: String, childC: String, infantsc infantsC: String) {
        // Convert string inputs to integers (if possible)
        if let adultCount = Int(adultC), let childCount = Int(childC), let infantsCount = Int(infantsC) {
            // Calculate the total passenger count
            let totalPassengers = adultCount + childCount + infantsCount
            
            // Update the text field with the total count
            passengerTF.text = "\(totalPassengers) Traveller(s)"
        } else {
            // Handle invalid input (non-integer values)
            passengerTF.text = "Invalid input"
        }
        // Resign first responder
        self.passengerTF.resignFirstResponder()
    }
    
    @IBAction func cabinBtn(_ sender: Any) {
        tableViewOption.showLoading()
        ApiManager.shared.flightcabins(user: "260") { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.checkText = 3
                    print("SUCSEEEEEE")
                    self.FlighcabinsModel = model
                    print(model)
                    self.CabinModel = model.result
                    self.tableViewOption.reloadData()
                    self.setupTableViewOption(tablevieww: self.tableViewOption)
                    self.tableViewOption.delegate = self
                    self.tableViewOption.dataSource = self
                    self.animateOptionTableView(tableVieww: self.tableViewOption, tag: 1, load: true)
                    print(self.FlighcabinsModel?.result?[0].code)
                    
                    self.tableViewOption.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func submitBtn(_ sender: Any) {
        self.submitBtn.showLoading()
        if fromTF.text == "" || toTF.text == "" || departonTF.text == "" {
            let alert = UIAlertController(title: "Please enter credentials", message: "Please enter username and password to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            self.submitBtn.stopLoading()
        }else{
            guard let fromField = self.fromTF.text else { return }
            guard let toField = self.toTF.text else { return }
            guard let departonField = self.departonTF.text else { return }
            guard let returnonField = self.returnonTF.text else { return }
            let cabinField = cabinvalues ?? defaultcabinvalue
            let adultCountField = adultCount ?? defaultValueForadultCount
            let childCountField = childCount ?? defaultValueForChildCount
            let infantsCountField = infantsCount ?? defaultValueForChildCount
            let tripTypeField = tripMood ?? defaulttripMood
            let departonCod = departonCode ?? defaulttripMood
            let departonCodess = departonCode
            let returnonCodess = returnonCode

                            let vc  = self.storyboard?.instantiateViewController(withIdentifier: "FlightListVC") as! FlightListVC
                            vc.fromTFField = fromField
                            vc.toTFField = toField
                            vc.departonTFField = departonField
                            vc.returnonTFField = returnonField
                            vc.cabinvalueTFField = cabinField
                            vc.adultCountTFField = adultCountField
                            vc.childCountTFField = childCountField
                            vc.infantsCountTFField = infantsCountField
                            vc.tripTypeTFField = tripTypeField
                            vc.departonCodes = departonCodess
                            vc.returnonCodes = returnonCodess
                            vc.departonDateCodes = departonField
                            vc.returnonDateCodes = returnonField
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true)
        }//end
    }
}
extension FlightConfirmVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        if textField == fromTF {
            if !updatedText.isEmpty {
                tableViewOption.showLoading()
                ApiManager.shared.flightairports(user: "260", keyword: updatedText) { result in
                    switch result {
                    case .success(let model):
                        DispatchQueue.main.async {
                            self.checkText = 1
                            print("SUCSEEEEEE")
                            self.flightAirportsModel = model
                            
                            print(model)
                            self.airportsModel = model.result
                            self.tableViewOption.reloadData()
                            self.setupTableViewOption(tablevieww: self.tableViewOption)
                            self.tableViewOption.delegate = self
                            self.tableViewOption.dataSource = self
                            self.animateOptionTableView(tableVieww: self.tableViewOption, tag: 1, load: true)
                            self.tableViewOption.stopLoading()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                animateOptionTableView(tableVieww: tableViewOption, tag: 1, load: false)
            }
        }
        if textField == toTF{
            if !updatedText.isEmpty {
                tableViewOption.showLoading()
                ApiManager.shared.flightairports(user: "260", keyword: updatedText) { result in
                    switch result {
                    case .success(let model):
                        DispatchQueue.main.async {
                            self.checkText = 2
                            print("SUCSEEEEEE")
                            
                            self.flightAirportsModel = model
                            print(model)
                            self.airportsModel = model.result
                            self.tableViewOption.reloadData()
                            self.setupTableViewOption(tablevieww: self.tableViewOption)
                            self.tableViewOption.delegate = self
                            self.tableViewOption.dataSource = self
                            self.animateOptionTableView(tableVieww: self.tableViewOption, tag: 1, load: true)
                            self.tableViewOption.stopLoading()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                animateOptionTableView(tableVieww: tableViewOption, tag: 1, load: false)
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passengerTF {
            self.passengerTF.resignFirstResponder()
            let aStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = aStoryboard.instantiateViewController(withIdentifier: "PassengerViewController") as! PassengerViewController
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    func setupTableViewOption(tablevieww: UITableView) {
        tablevieww.frame = CGRect(x: 20, y: view.frame.height, width: view.frame.width - 40, height: view.frame.height / 1.4)
        tablevieww.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tablevieww.layer.shadowOffset = CGSize(width: 0.8, height: 0.6)
        tablevieww.layer.shadowRadius = 2
        tablevieww.layer.shadowOpacity = 2
        tablevieww.layer.cornerRadius = 10
    }
    func animateOptionTableView(tableVieww: UITableView, tag: Int ,load: Bool) {
        if load {
            UIView.animate(withDuration: 0.2 ){
                tableVieww.frame = CGRect(x: 4, y: self.view.frame.height / 1.94, width: self.view.frame.width - 10, height: 440)
            }
            tableVieww.isHidden = false
            tableVieww.layer.borderWidth = 0.2
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {
                tableVieww.frame = CGRect(x: 20, y: self.view.frame.height, width: self.view.frame.width - 40, height: self.view.frame.height - 170)
            }) { done in
                for subView in self.view.subviews {
                    if  subView.tag == tag {
                        subView.isHidden = true
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkText == 1 {
            return flightAirportsModel?.result?.count ?? 0
        } else if checkText == 2 {
            return flightAirportsModel?.result?.count ?? 0
            // Replace 0 with the appropriate count
            return 0
        } else if checkText == 3 {
            return FlighcabinsModel?.result?.count ?? 0
            // Return the number of rows for checkText == 3
            // Replace 0 with the appropriate count
            return 0
        }
        // Return a default value (you may change this to 0 or some other value)
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if checkText == 1 {
            cell.textLabel?.text = airportsModel?[indexPath.row].value
            self.departonCode = (airportsModel?[indexPath.row].code)!
            
            
        } else if checkText == 2 {
            cell.textLabel?.text = airportsModel?[indexPath.row].value
            self.returnonCode = (airportsModel?[indexPath.row].code)!
            
            
        }else if checkText == 3 {
            cell.textLabel?.text = CabinModel?[indexPath.row].title
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if checkText == 1 {
            self.fromTF.text = airportsModel?[indexPath.row].value
        } else if checkText == 2 {
            self.toTF.text = airportsModel?[indexPath.row].value
        }else if checkText == 3 {
            self.cabinTF.text = CabinModel?[indexPath.row].title
            self.cabinvalues = CabinModel?[indexPath.row].code ?? defaultcabinvalue
        }
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true) // Should be true to end editing
        self.tableViewOption.endEditing(true) // Assuming tableViewOption is an input view that needs to end editing
        self.fromTF.endEditing(true) // Assuming fromTF is an input view that needs to end editing
        self.toTF.endEditing(true) // Assuming fromTF is an input view that needs to end editing
        self.view.backgroundColor = .systemBackground
        animateOptionTableView(tableVieww: tableViewOption, tag: 1, load: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

//
//self.submitBtn.showLoading()
//
//if fromTF.text == "" || toTF.text == "" || departonTF.text == "" || returnonTF.text == "" {
//    let alert = UIAlertController(title: "Please enter credentials", message: "Please enter username and password to continue", preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: nil))
//    present(alert, animated: true, completion: nil)
//    self.submitBtn.stopLoading()
//
//}else{
//
//    guard let fromField = self.fromTF.text else { return }
//    guard let toField = self.toTF.text else { return }
//    guard let departonField = self.departonTF.text else { return }
//    guard let returnonField = self.returnonTF.text else { return }
//    let cabinField = cabinvalues ?? defaultcabinvalue
//    let adultCountField = adultCount ?? defaultValueForChildCount1
//    let childCountField = childCount ?? defaultValueForChildCount
//    let infantsCountField = infantsCount ?? defaultValueForChildCount
//    let tripTypeField = tripMood ?? defaulttripMood
//
//    let vc  = self.storyboard?.instantiateViewController(withIdentifier: "FlightListViewController") as! FlightListVC
//    vc.fromTFField = fromField
//    vc.toTFField = toField
//    vc.departonTFField = departonField
//    vc.returnonTFField = returnonField
//    vc.cabinvalueTFField = cabinField
//    vc.adultCountTFField = adultCountField
//    vc.childCountTFField = childCountField
//    vc.infantsCountTFField = infantsCountField
//    vc.tripTypeTFField = tripTypeField
//    vc.departonCodes = self.departonCode
//    vc.returnonCodes = self.returnonCode
//    vc.modalPresentationStyle = .fullScreen
//    self.present(vc, animated: true)
