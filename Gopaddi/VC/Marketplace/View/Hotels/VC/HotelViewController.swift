//
//  HotelViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//

import UIKit
import Fastis
protocol PInfo{
    func clientDetails(occupancy : [Any] , roomC : Int , childC : Int , adultNo : Int)
}
class HotelViewController: UIViewController, PInfo {
    
    @IBOutlet weak var destinationTF: UITextField!
    @IBOutlet weak var personCountTF: UITextField!
    @IBOutlet weak var NightTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var dateBtn: UIButton!
    
    @IBOutlet weak var srcBtn: UIButton!
    private let tableViewOption: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tag = 1
        return tableView
    }()
    var night : String?
    var occupancyList: [Any]?
    var hDestinationResult : [HDestinationData]?
    var hotelList : [HotelListResult]?
    var room : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableViewOption)
        NightTF.isUserInteractionEnabled = false
        destinationTF.delegate = self
        dateTF.delegate = self
        personCountTF.delegate = self
        personCountTF.inputView = HotelsPopUpViewController().backView
//        dateTF.inputView = FastisController(mode: .range).view
    }
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func isEnabled_False(){
        destinationTF.isEnabled = false
        personCountTF.isEnabled = false
        NightTF.isEnabled = false
        destinationTF.isEnabled = false
        dateTF.isEnabled = false
        dateBtn.isEnabled = false
        srcBtn.isEnabled = false
        backBtn.isEnabled = false
    }
    func isEnabled_True(){
        destinationTF.isEnabled = true
        personCountTF.isEnabled = true
        NightTF.isEnabled = true
        destinationTF.isEnabled = true
        dateTF.isEnabled = true
        dateBtn.isEnabled = true
        srcBtn.isEnabled = true
        backBtn.isEnabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isEnabled_True()
    }

    override func viewDidAppear(_ animated: Bool) {
        isEnabled_True()
    }
    @IBAction func didTapSearch(_ sender: Any) {
        var isDate : Bool = false
        var isdestination : Bool = false
        var isCount : Bool = false
        guard let date = self.dateTF.text else { return }
        guard let destination = destinationTF.text else { return }
        guard let count = personCountTF.text else { return }
        
        if date.isEmpty{
            dateTF.attributedPlaceholder = NSAttributedString(
                string: " Date?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
            NightTF.attributedPlaceholder = NSAttributedString(
                string: " How many nights?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
            isDate = false
        }else{
            dateTF.attributedPlaceholder = NSAttributedString(
                string:  " Select Dates",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
            )
            isDate = true
        }
        if destination.isEmpty{
            destinationTF.attributedPlaceholder = NSAttributedString(
                string: "Where do you want to stay?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
            isdestination = false
        }else{
            destinationTF.attributedPlaceholder = NSAttributedString(
                string:  "Destination",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
            )
            isdestination = true
        }
        if count.isEmpty{
            personCountTF.attributedPlaceholder = NSAttributedString(
                string: "How many members?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
            isCount = false
        }else{
            personCountTF.attributedPlaceholder = NSAttributedString(
                string: "Night",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
            )
            isCount = true
        }
        if isDate,isCount,isdestination == true {
            do {
                isEnabled_False()
                print(occupancyList)
                view.showLoading()
                ApiManager.shared.hotelList(destination: destination,rooms: room!, nights: night!, dates: date, occupancy: occupancyList!){
                    result in
                    switch result {
                    case .success(let model) :
                        DispatchQueue.main.async {
                            self.view.stopLoading()
                            if model.code == "200" {
                                self.hotelList = model.result
                                let vc =  HotelListViewController()
                                vc.dateLabel.text = self.hotelList?[0].date
                                vc.titleLabel.text = self.destinationTF.text
                                vc.hotelListResult = self.hotelList
                                let nav = UINavigationController(rootViewController: vc)
                                nav.modalPresentationStyle = .fullScreen
                                self.present(nav, animated: true)
                            }
                            else {
                                self.isEnabled_True()
                                let alert = UIAlertController(title: "Sorry!", message: model.message, preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                                alert.addAction(alertAction)
                                self.present(alert, animated: true)
                            }
                        }
                    case .failure(let error) :
                        self.view.stopLoading()
                        print(error.localizedDescription)
                    }
                }
            }
        }
//        else{
//            let alert = UIAlertController(title: "Please fill all fields", message: "", preferredStyle: .alert)
//            let alertBtn = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(alertBtn)
//            self.present(alert, animated: false)
//        }
    }
    func chooseDate() {
        view.showLoading()
        let fastisController = FastisController(mode: .range)
        fastisController.title = "Choose range"
        fastisController.maximumDate = .distantFuture
        fastisController.minimumDate = .now
        fastisController.allowToChooseNilDate = false
        fastisController.shortcuts = [.today, .lastWeek]
        fastisController.dismissHandler = { action in
            switch action {
            case .done(let resultRange):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd" // Corrected date format
                let fromDate = dateFormatter.string(from: resultRange!.fromDate)
                let toDate = dateFormatter.string(from: resultRange!.toDate)
                self.dateTF.text = fromDate + " - " + toDate
                let calendar = Calendar.current
                if let fdate = dateFormatter.date(from: fromDate), let tdate = dateFormatter.date(from: toDate) {
                    let dateComponents = calendar.dateComponents([.day], from: fdate, to: tdate)
                    self.NightTF.text = "\(dateComponents.day ?? 0) Nights"
                    self.night = "\(dateComponents.day ?? 0)"
                }
                self.view.stopLoading()
                self.dateTF.resignFirstResponder()
            case .cancel:
                self.view.stopLoading()
                self.dateTF.resignFirstResponder()
            }
        }
        fastisController.present(above: self)
    }

    func clientDetails(occupancy: [Any], roomC : Int, childC : Int , adultNo : Int) {
        personCountTF.text = "  " + String(roomC) + " Rooms , " + String(adultNo) + " Adults & " + String(childC) + " Children"
        occupancyList = occupancy
        room = String(roomC)
        personCountTF.resignFirstResponder()
    }
    
    @IBAction func selectdatBtn(_ sender: Any) {
        let fastisController = FastisController(mode: .range)
        fastisController.title = "Choose range"
        fastisController.maximumDate = .distantFuture
        fastisController.minimumDate = .now
        fastisController.allowToChooseNilDate = false
        fastisController.shortcuts = [.today, .lastWeek]
        fastisController.dismissHandler = { action in
            switch action {
            case .done(let resultRange):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd" // Corrected date format
                let fromDate = dateFormatter.string(from: resultRange!.fromDate)
                let toDate = dateFormatter.string(from: resultRange!.toDate)
                self.dateTF.text = fromDate + " - " + toDate
                let calendar = Calendar.current
                if let fdate = dateFormatter.date(from: fromDate), let tdate = dateFormatter.date(from: toDate) {
                    let dateComponents = calendar.dateComponents([.day], from: fdate, to: tdate)
                    self.NightTF.text = "\(dateComponents.day ?? 0) Nights"
                    self.night = "\(dateComponents.day ?? 0)"
                }
                self.view.stopLoading()
                self.dateTF.resignFirstResponder()
            case .cancel:
                self.view.stopLoading()
                self.dateTF.resignFirstResponder()
            }
        }
        fastisController.present(above: self)
    }
    
   
    
}
extension HotelViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == destinationTF{
            if textField.text == "Destination" {
                textField.text = " "
            }
            self.tableViewOption.showLoading()
            if let text = textField.text
            {
                ApiManager.shared.hotelDestination(search: text)
                { result in
                    switch result {
                    case.success(let model):
                        DispatchQueue.main.async {
                            self.hDestinationResult = model
                            self.tableViewOption.reloadData()
                            self.setupTableViewOption(tablevieww: self.tableViewOption)
                            self.tableViewOption.delegate = self
                            self.tableViewOption.dataSource  = self
                            self.animateOptionTableView(tableVieww: self.tableViewOption, tag: 1, load: true)
                            self.tableViewOption.stopLoading()
                        }
                    case.failure(let error):
                        print(error.localizedDescription)
                        
                    }
                }
            }
        }
        if textField == personCountTF{
            personCountTF.placeholder = ""
            personCountTF.resignFirstResponder()
            let vc = storyboard?.instantiateViewController(withIdentifier: "HotelsPopUpViewController") as! HotelsPopUpViewController
            vc.delegate = self
            present(vc, animated: true)
        }
        if textField == dateTF{
            view.stopLoading()
        }
        if textField == NightTF{
            NightTF.placeholder = ""
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        destinationTF.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == personCountTF{
            personCountTF.placeholder = ""
            personCountTF.resignFirstResponder()
            let vc = storyboard?.instantiateViewController(withIdentifier: "HotelsPopUpViewController") as! HotelsPopUpViewController
            vc.delegate = self
            present(vc, animated: true)
        }
        if textField == dateTF{
            chooseDate()
            self.view.stopLoading()
        }
        if textField == NightTF{
            NightTF.placeholder = ""
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
            UIView.animate(withDuration: 0.2) {
                tableVieww.frame = CGRect(x: 4, y: self.view.frame.height / 1.94, width: self.view.frame.width - 10, height: 440)
                tableVieww.isHidden = false
                tableVieww.layer.borderWidth = 0.2
                
            }
        }else {
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
}
extension HotelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hDestinationResult?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = hDestinationResult?[indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.destinationTF.text = hDestinationResult?[indexPath.row].title
        view.endEditing(false)
        self.tableViewOption.resignFirstResponder()
        self.destinationTF.resignFirstResponder()
        self.view.backgroundColor = .systemBackground
        animateOptionTableView(tableVieww: tableViewOption, tag: 1, load: false)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

