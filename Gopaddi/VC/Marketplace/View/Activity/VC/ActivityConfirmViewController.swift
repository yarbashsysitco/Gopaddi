//
//  ActivityConfirmViewController.swift
//  Gopaddi
//
//  Created by jizan k on 28/04/23.
//

import UIKit
class ActivityConfirmViewController: UIViewController {

        private let tableView : UITableView = {
            let table = UITableView()
            table.separatorStyle = .none
            table.register(TravellerInfoTableViewCell.self , forCellReuseIdentifier: TravellerInfoTableViewCell.identifier)
            table.register(ActivityBookHeadTableViewCell.self , forCellReuseIdentifier: ActivityBookHeadTableViewCell.identifier)
            table.register(ActivityBookContactTableViewCell.self , forCellReuseIdentifier: ActivityBookContactTableViewCell.identifier)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.backgroundColor = .systemBackground
            return table
        }()
        var toD = String()
        var fromD = String()
        var datePicker  = UIDatePicker()
        var completion: ((String) -> Void)?
        var bookingDetails : BookingDetails?
        var childSurName: [String] = []
        var childFirstName: [String] = []
        var childLastName: [String] = []
        var adultSurName: [String] = []
        var adultFirstName: [String] = []
        var adultLastName: [String] = []
        var cancelleationJson : String = ""
        var activityBookInput : ActivityBookingInput?
        var activityBookingOnline : ActivityBookingOnline?
        var imgUrl = String()
        var ratekey = String()
        var searchID = String()
        var dates = String()
        var currency = String()
        var totPrice = String()
        var adultPrice = String()
        var childPrice = String()
        var duration = String()
        var activityName = String()
        var childNo : Int?
        var adultNo : Int?
        var isOk : Bool?
        var cancellation = [CancellationPolicy]()
        var CFn1,CFn2,CFn3,CFn4,CSn1,CSn2,CSn3,CSn4 ,CLn1, CLn2, CLn3, CLn4 : String?
        var AFn1,AFn2,AFn3,AFn4,ASn1,ASn2,ASn3,ASn4 ,ALn1, ALn2, ALn3, ALn4 : String?
    var hName : String? = ""
    var chekInD: String? = ""
    var pAdd : String? = ""
    var email : String? = ""
    var phNumber : String? = ""
    var section : Int?
    var row : Int?
var childTitle = ["Master", "Miss"]
var adultTitle = ["Mr", "Mrs"]
        var activityBookResponse :  BookingDetails?
        var activityDetailsResult = [ActivityDetailsResult]()
        override func viewDidLoad (){
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
           title = "Activity"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            navigationItem.leftBarButtonItem?.tintColor = .systemBlue
            view.addSubview(tableView)
            tableView.frame = view.bounds
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
             email  = UserDefaults.standard.string(forKey: "logemail") ?? UserDefaults.standard.string(forKey: "gemail") ?? UserDefaults.standard.string(forKey: "apEmail")
             phNumber  = UserDefaults.standard.string(forKey: "logphone") ?? UserDefaults.standard.string(forKey: "gphone") ?? UserDefaults.standard.string(forKey: "apPhone")
        }
        @objc private func didTapBackButton() {
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:  -10)
            ])
        }
        private func createDatePicker(texField : UITextField){
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            texField.inputAccessoryView = toolBar
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            texField.inputView = datePicker
            let doneButton  = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolBar.setItems([doneButton], animated: true)
            completion = { date in
                texField.text = date
                self.chekInD = date
            }
        }
        @objc private func donePressed(){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "yyyy-MM-dd"
            self.view.endEditing(false)
            let date = formatter.string(from: datePicker.date)
            completion?(date)
            
        }
    }
    extension ActivityConfirmViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
        enum TextFieldData: Int {
            case sirNameTF = 0
            case firstNameTF
            case lastNameTF
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 4
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return 1
            }
            if section == 1 {
                return adultNo ?? 0
            }
            if section == 2 {
                return childNo ?? 0
            }
            if section == 3 {
                return 1
            }
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookHeadTableViewCell.identifier, for: indexPath) as? ActivityBookHeadTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(activityDetailsResult: activityDetailsResult, index: indexPath.row, date: dates)
                return cell
            }
            if  indexPath.section == 1 || indexPath.section == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TravellerInfoTableViewCell.identifier, for: indexPath) as? TravellerInfoTableViewCell else {
                    return UITableViewCell()
                }
                
                if indexPath.section == 1{
                    cell.contactLabel.text = "Adult \(indexPath.row + 1)"+(" Details")
                    cell.drop.optionArray = adultTitle
                }
                if indexPath.section == 2{
                    cell.contactLabel.text = "Child \(indexPath.row + 1)"+(" Details")
                    cell.drop.optionArray = childTitle
                }
                cell.drop.didSelect{(selectedText , index ,id) in
                    let title = selectedText
                    self.getTitile(row: self.row! , section: self.section!, title: title)
                    }
                cell.drop.listWillDisappear() {
                    let indexPath = tableView.indexPath(for: cell)
                    self.row = indexPath!.row
                    let position:CGPoint = cell.drop.convert(CGPointZero, to:self.tableView)
                    self.section = self.tableView.indexPathForRow(at: position)!.section
                     
               }
                cell.drop.tag = indexPath.row
                cell.firstNameTF.tag = indexPath.row + 10
                cell.lastNameTF.tag = indexPath.row + 20
                cell.firstNameTF.delegate = self
                cell.lastNameTF.delegate = self
                return cell
            }
            
            if indexPath.section == 3 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookContactTableViewCell.identifier, for: indexPath) as? ActivityBookContactTableViewCell else {
                    return UITableViewCell()
                }
                cell.hotelNameTf.delegate = self
                cell.checkInDateTF.delegate = self
                cell.pAddressTF.delegate = self
                cell.emailTf.delegate = self
                cell.numberTf.delegate = self
                cell.emailTf.text = email
                cell.numberTf.text  = phNumber
                cell.hotelNameTf.tag = 1
                cell.checkInDateTF.tag = 2
                cell.pAddressTF.tag = 3
                cell.emailTf.tag = 4
                cell.numberTf.tag = 5
                
                cell.bookClicked = {
                    if !self.email!.isValidEmail(){
                        self.alert(msg : "Email ")
                    }
                    else if self.hName! == "" {
                        self.alert(msg : "Hotel Name ")
                    }
                    else if self.pAdd!.isEmpty || self.hName! == ""{
                        self.alert(msg : "Address ")
                    }
                    else if self.chekInD!.isEmpty || self.hName! == ""{
                        self.alert(msg : "Check-In Date ")
                    }
                    else if self.phNumber!.isEmpty || self.phNumber!.isValidContact{
                        self.alert(msg : "Phone Number ")
                    }else{
                        self.isOk = true
                            var title : [String?] = [self.ASn1,self.ASn2,self.ASn3,self.ASn4]
                            title = self.getList(count: self.adultNo ?? 0, list: title)
                            var fName : [String?] = [self.AFn1 , self.AFn2,self.AFn3,self.AFn4]
                            fName = self.getList(count: self.adultNo ?? 0, list: fName)
                            var lName : [String?] =  [self.ALn1,self.ALn2,self.ALn3,self.ALn4]
                            lName = self.getList(count: self.adultNo ?? 0, list: lName)
                            var cTitle : [String?] = [self.CSn1,self.CSn2,self.CSn3,self.CSn4]
                            cTitle = self.getList(count: self.childNo ?? 0, list: cTitle)
                            var cFName : [String?] = [self.CFn1 , self.CFn2,self.CFn3,self.CFn4]
                            cFName = self.getList(count: self.childNo ?? 0, list: cFName)
                            var cLName : [String?] =  [self.CLn1,self.CLn2,self.CLn3,self.CLn4]
                            cLName = self.getList(count: self.childNo ?? 0, list: cLName)
                            let userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
                        if self.isOk! {
                            do {
                                let jsonEncoder = JSONEncoder()
                                let jsonData = try jsonEncoder.encode(self.cancellation)
                                self.cancelleationJson = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
                                print(self.cancelleationJson)
                                
                            }catch let error{
                                print(error.localizedDescription)
                            }
                            if  self.adultNo == fName.count , self.adultNo == lName.count,self.childNo == cFName.count, self.childNo == cLName.count {
                                self.activityBookInput =  ActivityBookingInput(searchId: self.searchID, title: title, fName: fName, lName: lName, childtitle: cTitle, chfName: cFName, childlast: cLName, userId: userId, adultPrice: self.adultPrice , adultNo: String(self.adultNo ?? 0), childPrice: self.childPrice , childNo: String(self.childNo ?? 0) , totalPrice: self.totPrice , email: self.email , contactNumber: self.phNumber , address: self.pAdd ?? "", checkIn: self.chekInD ?? "",from: self.fromD, to:  self.toD , hotel: self.hName ?? "", ActivityName: self.activityName, ActivityImage: self.imgUrl, duration: self.duration, rateKey: self.ratekey, currency: self.currency)
                                self.callBookingApi(bookingInput: self.activityBookInput!, cancell: self.cancelleationJson)
                                
                            }else {
                                self.alertR()
                            }
                        }
                    }
//                    *****************
                // Only for verification
                    do {
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(self.activityBookInput)
                       let BookingInputs = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
                        print(BookingInputs)
                        
                    }catch let error{
                        print(error.localizedDescription)
                    }
//                    *****************
                    
                }
                return cell
            }
            return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 330
            }
            if indexPath.section == 3 {
                return 500
            }
            return 200
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            let position:CGPoint = textField.convert(CGPointZero, to:self.tableView)
            let section = self.tableView.indexPathForRow(at: position)?.section
            
            if section == 3 {
                if textField.tag == 2{
                    createDatePicker(texField: textField)
                    chekInD = textField.text ?? " "
                }
            }
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        }
        func getTitile(row: Int, section : Int, title: String){
            if section == 1{
                switch row {
                case 0 : ASn1 = title
                case 1 : ASn2 = title
                case 2 : ASn3 = title
                case 3 : ASn4 = title
                default:
                    print("Invalid")
                }
            }
            if section == 2{
                switch row {
                case 0 : CSn1 = title
                case 1 : CSn2 = title
                case 2 : CSn3 = title
                case 3 : CSn4 = title
                default:
                    print("Invalid")
                }
            }
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            let position:CGPoint = textField.convert(CGPointZero, to:self.tableView)
            let section = self.tableView.indexPathForRow(at: position)?.section
            
            if section == 1 {
              
                if textField.tag == 10 {
                    AFn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    ALn1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    AFn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    ALn2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    AFn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    ALn3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    AFn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    ALn4 = textField.text ?? " "
                }
            }
            if section == 2 {
                if textField.tag == 10 {
                    CFn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    CLn1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    CFn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    CLn2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    CFn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    CLn3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    CFn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    CLn4 = textField.text ?? " "
                }
            }
            if section == 3 {
                if textField.tag == 1{
                    hName = textField.text ?? " "
                }
                
                if textField.tag == 3{
                    pAdd = textField.text ?? " "
                }
                if textField.tag == 4{
                    email = textField.text ?? " "
                }
                if textField.tag == 5{
                    phNumber = textField.text ?? " "
                }
            }
        }
        func getList(count : Int , list : [String?]) -> [String] {
            var listVal : [String] = []
            if count != 0 {
                for i in 0...count - 1  {
                    if list[i] != nil {
                        if list[i] != ""{
                            listVal.append(list[i]!)
                        }
                        else{
                            alertR()
                            self.isOk = false
                        }
                    }else{
                        alertR()
                        self.isOk = false
                    }
                }
            }
            return listVal
        }
        func alertR(){
            let alert = UIAlertController(title: "Sorry!", message: "Some fields are Missing", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertButton)
            self.present(alert, animated: true)
        }
        func alert(msg : String){
            let alert = UIAlertController(title: "Fill \(msg)" + "fileds", message: "", preferredStyle: .alert)
            let alertBtn = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(alertBtn)
            self.present(alert, animated: false)
        }
            
        func callBookingApi(bookingInput : ActivityBookingInput , cancell : String){
            view.showLoading()
            ApiManager.shared.activityBooking(activity: bookingInput, cancellationP: cancell){ result in
                switch result {
                case .success(let model):
                    
                    DispatchQueue.main.async {
                        self.view.stopLoading()
                        self.activityBookingOnline = model
                        if model.code == "200" {
                            let vc = WeViewViewController()
                            vc.url = model.redirect ?? ""
                            let nav = UINavigationController(rootViewController: vc)
                            self.present(nav, animated: true)
                        }
                    }
                case .failure(let error):
                    self.view.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
    }


//        private let tableView : UITableView = {
//            let table = UITableView()
//            table.separatorStyle = .none
//            table.register(TravellerInfoTableViewCell.self , forCellReuseIdentifier: TravellerInfoTableViewCell.identifier)
//            table.register(ActivityBookHeadTableViewCell.self , forCellReuseIdentifier: ActivityBookHeadTableViewCell.identifier)
//            table.register(ActivityBookContactTableViewCell.self , forCellReuseIdentifier: ActivityBookContactTableViewCell.identifier)
//            table.translatesAutoresizingMaskIntoConstraints = false
//            return table
//        }()
//
//
//        var bookingDetails : BookingDetails?
//    var activityBookingOnline : ActivityBookingOnline?
//        var childSurName: [String] = []
//        var childFirstName: [String] = []
//        var childLastName: [String] = []
//        var adultSurName: [String] = []
//        var adultFirstName: [String] = []
//        var adultLastName: [String] = []
//        var names : [Names]?
//        var adultNames : [Names]?
//     var cancelleationJson : [Any] = []
//    var activityBookInput : ActivityBookingInput?
//        var imgUrl = String()
//        var ratekey = String()
//        var searchID = String()
//        var dates = String()
//    var totPrice = String()
//    var adultPrice = String()
//    var childPrice = String()
//    var duration = String()
//    var activityName = String()
//    var childNo : Int?
//    var adultNo : Int?
//        var cancellation = [CancellationPolicy]()
//        var CFn1,CFn2,CFn3,CFn4,CSn1,CSn2,CSn3,CSn4 ,CLn1, CLn2, CLn3, CLn4 : String?
//        var AFn1,AFn2,AFn3,AFn4,ASn1,ASn2,ASn3,ASn4 ,ALn1, ALn2, ALn3, ALn4 : String?
//        var hName,chekInD,pAdd,email,phNumber : String?
//        var activityBookResponse :  BookingDetails?
//        var activityDetailsResult = [ActivityDetailsResult]()
//        override func viewDidLoad (){
//            super.viewDidLoad()
//            title = "Activity"
//            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
//
//            navigationItem.titleView?.tintColor = .systemBlue
//            view.backgroundColor = .systemBackground
//            view.addSubview(tableView)
//            tableView.frame = view.bounds
//            tableView.dataSource = self
//            tableView.delegate = self
//            tableView.reloadData()
//        }
//        @objc private func didTapBackButton() {
//            dismiss(animated: true)
//        }
//        override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            NSLayoutConstraint.activate([
//                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:  -10)
//            ])
//        }
//    }
//    extension ActivityConfirmViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
//        enum TextFieldData: Int {
//            case sirNameTF = 0
//            case firstNameTF
//            case lastNameTF
//        }
//
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return 4
//        }
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            if section == 0 {
//                return 1
//            }
//            if section == 1 {
//                return adultNo ?? 0
//            }
//            if section == 2 {
//                return childNo ?? 0
//            }
//            if section == 3 {
//                return 1
//            }
//            return 1
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            if indexPath.section == 0 {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookHeadTableViewCell.identifier, for: indexPath) as? ActivityBookHeadTableViewCell else {
//                    return UITableViewCell()
//                }
//                cell.configure(activityDetailsResult: activityDetailsResult, index: indexPath.row, date: dates)
//                return cell
//            }
//            if  indexPath.section == 1 || indexPath.section == 2 {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: TravellerInfoTableViewCell.identifier, for: indexPath) as? TravellerInfoTableViewCell else {
//                    return UITableViewCell()
//                }
//
//                if indexPath.section == 1{
//                    cell.contactLabel.text = "Adult \(indexPath.row + 1)"+(" Details")
//                }
//                if indexPath.section == 2{
//                    cell.contactLabel.text = "Child \(indexPath.row + 1)"+(" Details")
//                }
//                cell.sirNameTF.tag = indexPath.row
//                cell.firstNameTF.tag = indexPath.row + 10
//                cell.lastNameTF.tag = indexPath.row + 20
//                cell.sirNameTF.delegate = self
//                cell.firstNameTF.delegate = self
//                cell.lastNameTF.delegate = self
//                cell.backgroundColor = .red
//                return cell
//            }
//
//            if indexPath.section == 3 {
//
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookContactTableViewCell.identifier, for: indexPath) as? ActivityBookContactTableViewCell else {
//                    return UITableViewCell()
//                }
//                cell.hotelNameTf.delegate = self
//                cell.checkInDateTF.delegate = self
//                cell.pAddressTF.delegate = self
//                cell.emailTf.delegate = self
//                cell.numberTf.delegate = self
//                cell.hotelNameTf.tag = 1
//                cell.checkInDateTF.tag = 2
//                cell.pAddressTF.tag = 3
//                cell.emailTf.tag = 4
//                cell.numberTf.tag = 5
//                cell.bookClicked = {
//                    var title : [String?] = [self.ASn1,self.ASn2,self.ASn3,self.ASn4]
//                    title = self.getList(count: self.adultNo ?? 0, list: title)
//                    var fName : [String?] = [self.AFn1 , self.AFn2,self.AFn3,self.AFn4]
//                    fName = self.getList(count: self.adultNo ?? 0, list: fName)
//                    var lName : [String?] =  [self.ALn1,self.ALn2,self.ALn3,self.ALn4]
//                    lName = self.getList(count: self.adultNo ?? 0, list: lName)
//                    var cTitle : [String?] = [self.CSn1,self.CSn2,self.CSn3,self.CSn4]
//                    cTitle = self.getList(count: self.adultNo ?? 0, list: cTitle)
//                    var cFName : [String?] = [self.CFn1 , self.CFn2,self.CFn3,self.CFn4]
//                    cFName = self.getList(count: self.adultNo ?? 0, list: cFName)
//                    var cLName : [String?] =  [self.CLn1,self.CLn2,self.CLn3,self.CLn4]
//                    cLName = self.getList(count: self.adultNo ?? 0, list: cLName)
//                     let userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
//
//                    do {
//                        let jsonEncoder = JSONEncoder()
//                        let jsonData = try jsonEncoder.encode(self.cancellation)
//                            let jsonString = String(data: jsonData, encoding: .utf8)
//                        let jsonData1 = (jsonString?.data(using: .utf8))!
//                        let json = try JSONSerialization.jsonObject(with: jsonData1, options: [])
//                        self.cancelleationJson.append(json)
//                    }catch let error{
//                        print(error.localizedDescription)
//                    }
//                    let toD = UserDefaults.standard.string(forKey: "toDate")
//                    let fromD = UserDefaults.standard.string(forKey: "fromDate")
//                    self.activityBookInput =  ActivityBookingInput(searchId: self.searchID, title: title, fName: fName, lName: lName, childTitle: cTitle, childFirst: cFName, childLast: cLName, userId: userId, adultPrice: self.adultPrice , adultNo: String(self.adultNo ?? 0), childPrice: self.childPrice , childNo: String(self.childNo ?? 0) , totalPrice: self.totPrice , email: self.email ?? "", contactNumber: self.phNumber ?? "", address: self.pAdd ?? "", checkIn: self.chekInD ?? "",from: fromD ,to: toD ,hotel: self.hName ?? "", ActivityName: self.activityName, ActivityImage: self.imgUrl, duration: self.duration, rateKey: self.ratekey)
//                    self.callBookingApi(bookingInput: self.activityBookInput!, cancell: self.cancelleationJson)
//                }
//                return cell
//            }
//            return UITableViewCell()
//        }
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            if indexPath.section == 0 {
//                return 330
//            }
//            if indexPath.section == 3 {
//                return 500
//            }
//            return 180
//        }
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//                let position:CGPoint = textField.convert(CGPointZero, to:self.tableView)
//                let section = self.tableView.indexPathForRow(at: position)?.section
//
//                if section == 1 {
//                    if textField.tag == 0 {
//                        ASn1 = textField.text ?? " "
//                    }
//                    if textField.tag == 10 {
//                        AFn1 = textField.text ?? " "
//                    }
//                    if textField.tag == 20 {
//                        ALn1 = textField.text ?? " "
//                    }
//                    if textField.tag == 1 {
//                        ASn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 11 {
//                        AFn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 21 {
//                        ALn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 2 {
//                        ASn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 12 {
//                        AFn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 22 {
//                        ALn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 3 {
//                        ASn3 = textField.text ?? " "
//                    }
//                    if textField.tag == 13 {
//                        AFn3 = textField.text ?? " "
//                    }
//                    if textField.tag == 23 {
//                        ALn3 = textField.text ?? " "
//                    }
//                }
//                if section == 2 {
//                    if textField.tag == 0 {
//                        CSn1 = textField.text ?? " "
//                    }
//                    if textField.tag == 10 {
//                        CFn1 = textField.text ?? " "
//                    }
//                    if textField.tag == 20 {
//                        CLn1 = textField.text ?? " "
//                    }
//                    if textField.tag == 1 {
//                        CSn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 11 {
//                        CFn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 21 {
//                        CLn2 = textField.text ?? " "
//                    }
//                    if textField.tag == 2 {
//                        CSn3 = textField.text ?? " "
//                    }
//                    if textField.tag == 12 {
//                        CFn3 = textField.text ?? " "
//                    }
//                    if textField.tag == 22 {
//                        CLn3 = textField.text ?? " "
//                    }
//                    if textField.tag == 3 {
//                        CSn4 = textField.text ?? " "
//                    }
//                    if textField.tag == 13 {
//                        CFn4 = textField.text ?? " "
//                    }
//                    if textField.tag == 23 {
//                        CLn4 = textField.text ?? " "
//                    }
//                }
//                if section == 3 {
//                    if textField.tag == 1{
//                        hName = textField.text ?? " "
//                    }
//                    if textField.tag == 2{
//                        chekInD = textField.text ?? " "
//                    }
//                    if textField.tag == 3{
//                        pAdd = textField.text ?? " "
//                    }
//                    if textField.tag == 4{
//                        email = textField.text ?? " "
//                    }
//                    if textField.tag == 5{
//                        phNumber = textField.text ?? " "
//                }
//            }
//        }
//        func getList(count : Int , list : [String?]) -> [String] {
//            var listVal : [String] = []
//            if count != 0 {
//                for i in 0...count - 1  {
//                    listVal.append(list[i] ?? "0")
//                }
//            }
//            return listVal
//        }
//        func alert(msg : String){
//            let alert = UIAlertController(title: "Fill \(msg)" + "fileds", message: "", preferredStyle: .alert)
//            let alertBtn = UIAlertAction(title: "OK", style: .default)
//
//            alert.addAction(alertBtn)
//            self.present(alert, animated: false)
//        }
//        func callBookingApi(bookingInput : ActivityBookingInput , cancell : [Any]){
//            view.showLoading()
//            ApiManager.shared.activityBooking(activity: bookingInput, cancellationP: cancell){ result in
//                switch result {
//                case .success(let model):
//
//                    DispatchQueue.main.async {
//                        self.view.stopLoading()
//                        self.activityBookingOnline = model
//                        if model.code == "200" {
//                            let vc = WeViewViewController()
//                            vc.url = model.redirect
//                            let nav = UINavigationController(rootViewController: vc)
//                            self.present(nav, animated: true)
//                        }
//                    }
//                case .failure(let error):
//                    self.view.stopLoading()
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
