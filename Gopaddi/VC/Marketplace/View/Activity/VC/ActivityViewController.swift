//
//  ActivityViewController.swift
//  Gopaddi
//
//  Created by jizan k on 12/05/23.
//

import UIKit
import Fastis
protocol PeopleCount{
    func peopleCount(adultC : String, childC : String ,childrenAgesList : [Int])
}
class ActivityViewController: UIViewController ,PeopleCount{
    
    var model = [DestinationResult]()
    var models = [DestinationData]()
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var personCountTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var countBtn: UIButton!
    
    @IBOutlet weak var srchBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    private let tableViewOption: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.tag = 1
        return tableView
    }()
    
    var childrenAges : [Int]?
    var adultCount : String?
    var childCount : String?
    var activityListResponse : ActivityListResponse?
    var dateString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableViewOption)
        locationTF.delegate = self
        dateTF.delegate = self
        personCountTF.delegate = self
        //        dateTF.inputView = FastisController(mode: .range).view
        personCountTF.inputView = MemberCountViewController().backView
    }
    func peopleCount(adultC: String, childC: String, childrenAgesList : [Int]) {
        adultCount = adultC
        childCount = childC
        personCountTF.text = adultC + " Adults & " + childC + " Children"
        childrenAges = childrenAgesList
        personCountTF.resignFirstResponder()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func isEnabled_False(){
        locationTF.isEnabled = false
        personCountTF.isEnabled = false
        srchBtn.isEnabled = false
        backBtn.isEnabled = false
        countBtn.isEnabled = false
        dateBtn.isEnabled = false
    }
    func isEnabled_True(){
        locationTF.isEnabled = true
        personCountTF.isEnabled = true
        srchBtn.isEnabled = true
        backBtn.isEnabled = true
        countBtn.isEnabled = true
        dateBtn.isEnabled = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isEnabled_True()
    }

    override func viewDidAppear(_ animated: Bool) {
        isEnabled_True()
    }
    @IBAction func didTapSearch(_ sender: Any) {
        let userLoginKey = UserDefaults.standard.string(forKey: "logkey")!
        guard let location = locationTF.text else { return}
        guard let date = dateTF.text else { return }
        guard let personCount = personCountTF.text else { return }
        let childrenAgesList = childrenAges ?? []
        let adultCount = adultCount ?? "1"
        let childCount = childCount ?? "0"
        if location.isEmpty || date.isEmpty || personCount.isEmpty {
            locationTF.attributedPlaceholder = NSAttributedString(
                string: " Location?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            dateTF.attributedPlaceholder = NSAttributedString(
                string: " Date?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            personCountTF.attributedPlaceholder = NSAttributedString(
                string: "How many members?",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
            )
        }else {
            isEnabled_False()
            srchBtn.showLoading()
            ApiManager.shared.activityList(location: location, date: date, adultNo: adultCount, childNo: childCount, childAges: childrenAgesList, userId: userLoginKey) { [weak self] result in
                switch result {
                case .success(let model) :
                    DispatchQueue.main.async {
                        self?.view.stopLoading()
                        if model.code == "200" {
                            self?.activityListResponse = model
                            let vc = ActivityListViewController()
                            vc.titleLabel.text = self?.locationTF.text ?? ""
                            vc.dateLabel.text = self?.dateString ?? " "
                            vc.dateAPI = self?.dateTF.text ?? " "
                            vc.activityListResult = self?.activityListResponse?.result
                            let navVC =  UINavigationController(rootViewController: vc)
                            navVC.modalPresentationStyle = .fullScreen
                            self?.present(navVC, animated: true)
                        }
                        else {
                            let alert = UIAlertController(title: "Sorry!", message: model.message, preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                            alert.addAction(alertAction)
                            self?.present(alert, animated: true)
                        }
                    }
                case .failure(let error) :
                    self?.view.stopLoading()
                    print(error.localizedDescription)
                }
            }
        }
    }
    @IBAction func dateBtn(_ sender: Any) {
        
        print("kbskxbaksxa")
        
        let fastisController = FastisController(mode: .range)
        fastisController.title = "Choose range"
        fastisController.maximumDate = .distantFuture
        fastisController.minimumDate = .now
        fastisController.allowToChooseNilDate = false
        fastisController.shortcuts = [.today, .lastWeek]
        
        fastisController.dismissHandler = { action in
            if case .done(let resultRange) = action {
                self.view.stopLoading()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY/MM/dd"
                let fromDate = dateFormatter.string(from: resultRange!.fromDate)
                let toDate = dateFormatter.string(from: resultRange!.toDate)
                self.dateTF.text = fromDate + " - " + toDate
                dateFormatter.dateFormat = "MMMM d, yyyy"
                let frDate = dateFormatter.string(from: resultRange!.fromDate)
                let tDate = dateFormatter.string(from: resultRange!.toDate)
                self.dateString = frDate + " - " + tDate
                dateFormatter.dateFormat = "YYYY-MM-dd"
                let fromD = dateFormatter.string(from: resultRange!.fromDate)
                let toD = dateFormatter.string(from: resultRange!.toDate)
                UserDefaults.standard.set(fromD, forKey: "fromDate")
                UserDefaults.standard.set(toD, forKey: "toDate")
            }
        }
        
        fastisController.present(above: self)
    }
    
  
    
    @IBAction func countBtn(_ sender: Any) {
        
        let aStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = aStoryboard.instantiateViewController(withIdentifier: "MemberCountViewController") as! MemberCountViewController
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    func chooseDate() {
      
    }
    
    
    
    
}
extension ActivityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTF.resignFirstResponder()
    }
    internal func textFieldDidChangeSelection(_ textField: UITextField)  {
        if textField == locationTF{
            if textField.text == "Destination" {
                textField.text = " "
            }
            self.tableViewOption.showLoading()
            if let text = textField.text {
                ApiManager.shared.activityDestination(search: text)
                { result in
                    switch result {
                    case.success(let model):
                        DispatchQueue.main.async {
                            self.models = model
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
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateTF {
            chooseDate()
            self.view.stopLoading()
        }
        else if textField == personCountTF {
           
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
}
extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].destinationList
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        self.locationTF.text = models[indexPath.row].destinationList
        view.endEditing(true)
        self.tableViewOption.resignFirstResponder()
        self.locationTF.resignFirstResponder()
        self.view.backgroundColor = .systemBackground
        animateOptionTableView(tableVieww: tableViewOption, tag: 1, load: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
