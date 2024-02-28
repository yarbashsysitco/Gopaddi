//
//  HotelConfirmViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import iOSDropDown

class HotelConfirmViewController: UIViewController {
        private let tableView : UITableView = {
            let table = UITableView()
            table.separatorStyle = .none
            table.register(TravellerInfoTableViewCell.self , forCellReuseIdentifier: TravellerInfoTableViewCell.identifier)
            table.register(HotelConfirmHeadTableViewCell.self , forCellReuseIdentifier: HotelConfirmHeadTableViewCell.identifier)
            table.register(HotelContactTableViewCell.self , forCellReuseIdentifier: HotelContactTableViewCell.identifier)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.backgroundColor = .systemBackground
            return table
        }()
   
        var hotelDetails : [HotelDetail]?
        var indexPathRow = Int()
        var childSurName: [String] = []
        var childFirstName: [String] = []
        var childLastName: [String] = []
        var adultSurName: [String] = []
        var adultFirstName: [String] = []
        var adultLastName: [String] = []
        var hotelBookInput : HotelBookingInput?
        var hotelBookingOnline : HotelBookingOnline?
        var imgUrl = String()
        var ratekey = String()
        var searchID = String()
        var dates = String()
        var totPrice = String()
        var adultPrice = String()
        var childPrice = String()
        var duration = String()
        var currentRoom : Int = 1
        var nextRoom : Int = 1
        var childNo : Int?
        var adultNo : Int?
        var rooms : Int = 1
        var i : Int = 1
        var section : Int?
        var row : Int?
    var isOk : Bool = true
    var childTitle = ["Master", "Miss"]
    var adultTitle = ["Mr", "Mrs"]
        var paxDetail : [Any] = []
        var cancellation = [CancellationPolicy]()
        var CFn1,CFn2,CFn3,CFn4,CSn1,CSn2,CSn3,CSn4 ,CLn1, CLn2, CLn3, CLn4 : String?
        var AFn1,AFn2,AFn3,AFn4,ASn1,ASn2,ASn3,ASn4 ,ALn1, ALn2, ALn3, ALn4 : String?
        var C2Fn1,C2Fn2,C2Fn3,C2Fn4,C2Sn1,C2Sn2,C2Sn3,C2Sn4 ,C2Ln1, C2Ln2, C2Ln3, C2Ln4 : String?
        var A2Fn1,A2Fn2,A2Fn3,A2Fn4,A2Sn1,A2Sn2,A2Sn3,A2Sn4 ,A2Ln1, A2Ln2, A2Ln3, A2Ln4 : String?
        var C3Fn1,C3Fn2,C3Fn3,C3Fn4,C3Sn1,C3Sn2,C3Sn3,C3Sn4 ,C3Ln1, C3Ln2, C3Ln3, C3Ln4 : String?
        var A3Fn1,A3Fn2,A3Fn3,A3Fn4,A3Sn1,A3Sn2,A3Sn3,A3Sn4 ,A3Ln1, A3Ln2, A3Ln3, A3Ln4 : String?
        var C4Fn1,C4Fn2,C4Fn3,C4Fn4,C4Sn1,C4Sn2,C4Sn3,C4Sn4 ,C4Ln1, C4Ln2, C4Ln3, C4Ln4 : String?
        var A4Fn1,A4Fn2,A4Fn3,A4Fn4,A4Sn1,A4Sn2,A4Sn3,A4Sn4 ,A4Ln1, A4Ln2, A4Ln3, A4Ln4 : String?
        var hName,chekInD,pAdd: String?
        var email : String = ""
        var phNumber : String = ""
        var activityBookResponse :  BookingDetails?
        var activityDetailsResult = [ActivityDetailsResult]()
        override func viewDidLoad (){
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Hotel"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
            navigationItem.leftBarButtonItem?.tintColor = .systemBlue
            tableView.reloadData()
            view.addSubview(tableView)
            tableView.frame = view.bounds
            tableView.dataSource = self
            tableView.delegate = self
            tableView.reloadData()
            email  = UserDefaults.standard.string(forKey: "logemail") ?? UserDefaults.standard.string(forKey: "gemail") ?? UserDefaults.standard.string(forKey: "apEmail") ?? ""
            phNumber  = UserDefaults.standard.string(forKey: "logphone") ?? UserDefaults.standard.string(forKey: "gphone") ?? UserDefaults.standard.string(forKey: "apPhone") ?? ""
            
        }
        @objc private func didTapBackButton() {
            dismiss(animated: true)
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:     0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant:  -10)
            ])
        }
    }
    extension HotelConfirmViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            rooms = Int(self.hotelDetails?[0].rooms ?? "1") ?? 1
            return 2 + rooms * 2
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            for i in 1...rooms{
                if section == i * 2 - 1  {
                    return "Room No : \(i)"
                }
            }
            return nil
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if section == 0 {
                return 1
            }
            for i in 1...rooms{
                if section == i * 2 - 1  {
                    adultNo = self.hotelDetails?[0].occupancy[i-1].adult
                    return adultNo ?? 1
                }
                if section == i * 2 {
                    childNo = self.hotelDetails?[0].occupancy[i-1].child
                    return childNo ?? 0
                }
            }
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelConfirmHeadTableViewCell.identifier, for: indexPath) as? HotelConfirmHeadTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            for i in 1...rooms{
                childNo = self.hotelDetails?[0].occupancy[i-1].child
                if indexPath.section == i * 2 - 1  || indexPath.section == i * 2 && childNo != 0{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravellerInfoTableViewCell.identifier, for: indexPath) as? TravellerInfoTableViewCell else {
                        return UITableViewCell()
                    }
                    if indexPath.section == i * 2 - 1 {
                        cell.contactLabel.text = "Room No : \(i) - " + "Adult \(indexPath.row + 1)"+(" Details")
                        cell.drop.optionArray = adultTitle
                    }
                    if indexPath.section == i * 2 && childNo != 0 {
                        cell.contactLabel.text = "Room No : \(i) - " + "Child \(indexPath.row + 1)"+(" Details")
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
            }
            
            if indexPath.section == rooms * 2 + 1  {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelContactTableViewCell.identifier, for: indexPath) as? HotelContactTableViewCell else {
                    return UITableViewCell()
                }
                cell.emailTf.delegate = self
                cell.numberTf.delegate = self
                cell.emailTf.text = email
                cell.numberTf.text = phNumber
                cell.emailTf.tag = 4
                cell.numberTf.tag = 5
                cell.bookClicked = {
                    if !self.email.isValidEmail(){
                        self.alert(msg : "Email")
                    }
                    else if self.phNumber.isEmpty || self.phNumber.isValidContact{
                        self.alert(msg : "Phone Number")
                    }
                    else {
                        var totAdultNo  = 0
                        var totChildNo  = 0
                        self.isOk = self.updateRoomList()
                        let userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
                        for i in 1...self.rooms{
                            totAdultNo = totAdultNo + (self.hotelDetails?[0].occupancy[i-1].adult ?? 0)
                          
                            totChildNo = totChildNo + (self.hotelDetails?[0].occupancy[i-1].child ?? 0)
                        }
                        if self.isOk {
                            self.hotelBookInput = HotelBookingInput(amount: self.hotelDetails?[0].roomrates[self.indexPathRow].markup, searchId: self.searchID, userId: userId, sessionId: self.hotelDetails?[0].sessionId, tokenId: self.hotelDetails?[0].tokenId, productId: self.hotelDetails?[0].productId, rateBasisId: self.hotelDetails?[0].roomrates[self.indexPathRow].rateBasisId, nights: self.hotelDetails?[0].nights, rooms: self.hotelDetails?[0].rooms, adults: String(totAdultNo), child: String(totChildNo), email: self.email, phone: self.phNumber)
                            self.callBookingApi(bookingInput: self.hotelBookInput!, pxDetail: self.paxDetail)
                        }
                        // Only for verification ****************
                            do {
                                let jsonEncoder = JSONEncoder()
                                let jsonData = try jsonEncoder.encode(self.hotelBookInput)
                               let BookingInputs = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
                                print(BookingInputs)
                                print(self.paxDetail)
                                
                            }catch let error{
                                print(error.localizedDescription)
                            }
//                        *****************************
                    }
                }
                
                return cell
            }
            return UITableViewCell()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 110
            }
            if indexPath.section == rooms * 2 + 1 {
                return 300
            }
            return 200
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
            if section == 3{
                switch row {
                case 0 : A2Sn1 = title
                case 1 : A2Sn2 = title
                case 2 : A2Sn3 = title
                case 3 : A2Sn4 = title
                default:
                    print("Invalid")
                }
            }
            if section == 4{
                switch row {
                case 0 : C2Sn1 = title
                case 1 : C2Sn2 = title
                case 2 : C2Sn3 = title
                case 3 : C2Sn4 = title
                default:
                    print("Invalid")
                }
            }
            if section == 5{
                switch row {
                case 0 : A3Sn1 = title
                case 1 : A3Sn2 = title
                case 2 : A3Sn3 = title
                case 3 : A3Sn4 = title
                default:
                    print("Invalid")
                }
            }
            if section == 6{
                switch row {
                case 0 : C3Sn1 = title
                case 1 : C3Sn2 = title
                case 2 : C3Sn3 = title
                case 3 : C3Sn4 = title
                default:
                    print("Invalid")
                }
            }
            if section == 7{
                switch row {
                case 0 : A4Sn1 = title
                case 1 : A4Sn2 = title
                case 2 : A4Sn3 = title
                case 3 : A4Sn4 = title
                default:
                    print("Invalid")
                }
            }
            if section == 8{
                switch row {
                case 0 : C4Sn1 = title
                case 1 : C4Sn2 = title
                case 2 : C4Sn3 = title
                case 3 : C4Sn4 = title
                default:
                    print("Invalid")
                }
            }
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            let position:CGPoint = textField.convert(CGPointZero, to:self.tableView)
            let section = self.tableView.indexPathForRow(at: position)?.section
            for i in 1...rooms{
                if section == i * 2 - 1  {
                    adultNo = self.hotelDetails?[0].occupancy[i-1].adult
                }
                if section == i * 2 {
                    childNo = self.hotelDetails?[0].occupancy[i-1].child
                }
            }
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
            if section == 2
            {
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
              
                if textField.tag == 10 {
                    A2Fn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    A2Ln1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    A2Fn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    A2Ln2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    A2Fn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    A2Ln3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    A2Fn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    A2Ln4 = textField.text ?? " "
                }
            }
            if section == 4
            {
                if textField.tag == 10 {
                    C2Fn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    C2Ln1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    C2Fn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    C2Ln2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    C2Fn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    C2Ln3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    C2Fn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    C2Ln4 = textField.text ?? " "
                }
            }
            if section == 5 {
              
                if textField.tag == 10 {
                    A3Fn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    A3Ln1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    A3Fn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    A3Ln2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    A3Fn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    A3Ln3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    A3Fn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    A3Ln4 = textField.text ?? " "
                }
            }
            if section == 6 
            {
                if textField.tag == 10 {
                    C3Fn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    C3Ln1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    C3Fn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    CLn2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    C3Fn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    C3Ln3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    C3Fn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    C3Ln4 = textField.text ?? " "
                }
            }
            if section == 7 {
            
                if textField.tag == 10 {
                    A4Fn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    A4Ln1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    AFn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    A4Ln2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    A4Fn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    A4Ln3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    A4Fn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    A4Ln4 = textField.text ?? " "
                }
            }
            if section == 8 && childNo != 0
            {
                if textField.tag == 10 {
                    C4Fn1 = textField.text ?? " "
                }
                if textField.tag == 20 {
                    C4Ln1 = textField.text ?? " "
                }
                if textField.tag == 11 {
                    C4Fn2 = textField.text ?? " "
                }
                if textField.tag == 21 {
                    C4Ln2 = textField.text ?? " "
                }
                if textField.tag == 12 {
                    C4Fn3 = textField.text ?? " "
                }
                if textField.tag == 22 {
                    C4Ln3 = textField.text ?? " "
                }
                if textField.tag == 13 {
                    C4Fn4 = textField.text ?? " "
                }
                if textField.tag == 23 {
                    C4Ln4 = textField.text ?? " "
                }
            }
            if section == rooms * 2 + 1 {
                if textField.tag == 4{
                    email = textField.text ?? ""
                }
                if textField.tag == 5{
                    phNumber = textField.text ?? ""
                }
            }
        }
        func updateRoomList() -> Bool{
            self.paxDetail.removeAll()
            var totalChildNo : Int = 0
            var totalAdultNo : Int = 0
            for i in 1...rooms {
                let currentChildNo = (self.hotelDetails?[0].occupancy[i-1].child ?? 0)
                let  currentAdultNo = (self.hotelDetails?[0].occupancy[i-1].adult ?? 0)
                totalAdultNo += currentAdultNo
                totalChildNo += currentChildNo
                switch i {
                case 1 :
                    var title : [String?] = [self.ASn1,self.ASn2,self.ASn3,self.ASn4]
                    title = self.getList(count: currentAdultNo , list: title, room: i)
                    var fName : [String?] = [self.AFn1 , self.AFn2,self.AFn3,self.AFn4]
                    fName = self.getList(count: currentAdultNo , list: fName, room: i)
                    var lName : [String?] =  [self.ALn1,self.ALn2,self.ALn3,self.ALn4]
                    lName = self.getList(count: currentAdultNo , list: lName, room: i)
                    var cTitle : [String?] = [self.CSn1,self.CSn2,self.CSn3,self.CSn4]
                    cTitle = self.getList(count: currentChildNo , list: cTitle, room: i)
                    var cFName : [String?] = [self.CFn1 , self.CFn2,self.CFn3,self.CFn4]
                    cFName = self.getList(count: currentChildNo , list: cFName, room: i)
                    var cLName : [String?] =  [self.CLn1,self.CLn2,self.CLn3,self.CLn4]
                    cLName = self.getList(count: currentChildNo , list: cLName, room: i)
                    if  currentAdultNo == fName.count , currentAdultNo == title.count, currentAdultNo == lName.count,currentChildNo == cTitle.count,currentChildNo == cFName.count, currentChildNo == cLName.count {
                            let pDetail = PaxDetail(roomNo: 1, adult: [Adult.init(title: title, firstName: fName, lastName: lName)], child: [Adult(title: cTitle, firstName: cFName, lastName: cLName)])
                            addData(pDetails: pDetail)
                    }else {
                        alertR(msg: "Room 1")
                        return false
                    }
                    
                case 2 :
                    var title : [String?] = [self.A2Sn1,self.A2Sn2,self.A2Sn3,self.A2Sn4]
                    title = self.getList(count: currentAdultNo , list: title, room: i)
                    var fName : [String?] = [self.A2Fn1 , self.A2Fn2,self.A2Fn3,self.A2Fn4]
                    fName = self.getList(count: currentAdultNo , list: fName, room: i)
                    var lName : [String?] =  [self.A2Ln1,self.A2Ln2,self.A2Ln3,self.A2Ln4]
                    lName = self.getList(count: currentAdultNo , list: lName, room: i)
                    var cTitle : [String?] = [self.C2Sn1,self.C2Sn2,self.C2Sn3,self.C2Sn4]
                    cTitle = self.getList(count: currentChildNo , list: cTitle, room: i)
                    var cFName : [String?] = [self.C2Fn1 , self.C2Fn2,self.C2Fn3,self.C2Fn4]
                    cFName = self.getList(count: currentChildNo , list: cFName, room: i)
                    var cLName : [String?] =  [self.C2Ln1,self.C2Ln2,self.C2Ln3,self.C2Ln4]
                    cLName = self.getList(count: currentChildNo , list: cLName, room: i)
                    if  currentAdultNo == fName.count , currentAdultNo == title.count, currentAdultNo == lName.count,currentChildNo == cTitle.count,currentChildNo == cFName.count, currentChildNo == cLName.count{
                            let pDetail = PaxDetail(roomNo: 2, adult: [Adult.init(title: title, firstName: fName, lastName: lName)], child: [Adult(title: cTitle, firstName: cFName, lastName: cLName)])
                            addData(pDetails: pDetail)
                    }else {
                        alertR(msg: "Room 2")
                        return false
                    }
                    
                case 3 :
                    var title : [String?] = [self.A3Sn1,self.A3Sn2,self.A3Sn3,self.A3Sn4]
                    title = self.getList(count: currentAdultNo , list: title, room: i)
                    var fName : [String?] = [self.A3Fn1 , self.A3Fn2,self.A3Fn3,self.A3Fn4]
                    fName = self.getList(count: currentAdultNo , list: fName, room: i)
                    var lName : [String?] =  [self.A3Ln1,self.A3Ln2,self.A3Ln3,self.A3Ln4]
                    lName = self.getList(count: currentAdultNo , list: lName, room: i)
                    var cTitle : [String?] = [self.C3Sn1,self.C3Sn2,self.C3Sn3,self.C3Sn4]
                    cTitle = self.getList(count: currentChildNo , list: cTitle, room: i)
                    var cFName : [String?] = [self.C3Fn1 , self.C3Fn2,self.C3Fn3,self.C3Fn4]
                    cFName = self.getList(count: currentChildNo , list: cFName, room: i)
                    var cLName : [String?] =  [self.C3Ln1,self.C3Ln2,self.C3Ln3,self.C3Ln4]
                    cLName = self.getList(count: currentChildNo , list: cLName, room: i)
                    if  currentAdultNo == fName.count , currentAdultNo == title.count, currentAdultNo == lName.count,currentChildNo == cTitle.count,currentChildNo == cFName.count, currentChildNo == cLName.count {
                            let pDetail = PaxDetail(roomNo: 3, adult: [Adult.init(title: title, firstName: fName, lastName: lName)], child: [Adult(title: cTitle, firstName: cFName, lastName: cLName)])
                            addData(pDetails: pDetail)
                    }else {
                        alertR(msg: "Room 3")
                        return false
                    }
                case 4 :
                    var title : [String?] = [self.A4Sn1,self.A4Sn2,self.A4Sn3,self.A4Sn4]
                    title = self.getList(count: currentAdultNo , list: title, room: i)
                    var fName : [String?] = [self.A4Fn1 , self.A4Fn2,self.A4Fn3,self.A4Fn4]
                    fName = self.getList(count: currentAdultNo , list: fName, room: i)
                    var lName : [String?] =  [self.A4Ln1,self.A4Ln2,self.A4Ln3,self.A4Ln4]
                    lName = self.getList(count: currentAdultNo , list: lName, room: i)
                    var cTitle : [String?] = [self.C4Sn1,self.C4Sn2,self.C4Sn3,self.C4Sn4]
                    cTitle = self.getList(count: currentChildNo , list: cTitle, room: i)
                    var cFName : [String?] = [self.C4Fn1 , self.C4Fn2,self.C4Fn3,self.C4Fn4]
                    cFName = self.getList(count: currentChildNo , list: cFName, room: i)
                    var cLName : [String?] =  [self.C4Ln1,self.C4Ln2,self.C4Ln3,self.C4Ln4]
                    cLName = self.getList(count: currentChildNo , list: cLName, room: i)
                    if  currentAdultNo == fName.count , currentAdultNo == title.count, currentAdultNo == lName.count,currentChildNo == cTitle.count,currentChildNo == cFName.count, currentChildNo == cLName.count {
                            let pDetail = PaxDetail(roomNo: 4, adult: [Adult.init(title: title, firstName: fName, lastName: lName)], child: [Adult(title: cTitle, firstName: cFName, lastName: cLName)])
                            addData(pDetails: pDetail)
                    }else {
                        alertR(msg: "Room 4")
                    }
                default:
                    print("Invalid")
                    return false
                }
            }
            return true
        }
        func addData(pDetails : PaxDetail){
            
            do {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(pDetails)
                let jsonString = String(data: jsonData, encoding: .utf8)
                let jsonData1 = (jsonString?.data(using: .utf8))!
                let json = try JSONSerialization.jsonObject(with: jsonData1, options: [])
                self.paxDetail.append(json)
                print(paxDetail)
            }catch let error{
                print(error.localizedDescription)
            }
        }
        func getList(count : Int , list : [String?], room : Int) -> [String] {
            var listVal : [String] = []
            if count != 0 {
                for i in 0...count - 1  {
                    if list[i] != nil {
                        if list[i] != ""{
                            listVal.append(list[i]!)
                        }
                        else{
                            alertR(msg: " Room \(room)")
                            isOk = false
                        }
                    }else{
                        alertR(msg: " Room \(room)")
                        isOk = false
                    }
                    
                }
            }
            return listVal
        }
        
        func alertR(msg : String){
            let alert = UIAlertController(title: "Sorry!", message: "Some fileds in \(msg)" + " are missing ", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertButton)
            self.present(alert, animated: true)
        }
        
        func alert(msg : String){
            let alert = UIAlertController(title: "", message: "Enter valid +\(msg)", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertButton)
            self.present(alert, animated: true)
        }
        
        func callBookingApi(bookingInput : HotelBookingInput , pxDetail : [Any]){
                            view.showLoading()
            ApiManager.shared.hotelBookingOnline(hotel: bookingInput, paxDetail: pxDetail){ result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        if model.code == "200" {
                                self.view.stopLoading()
                                self.hotelBookingOnline = model
                                let vc = HotelWebViewController()
                                vc.url = model.redirect ?? ""
                            vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                        }else{
                            self.view.stopLoading()
                        }
                    }
                case .failure(let error):
                    self.view.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
    }

