//
//  BookingSelectionViewController.swift
//  Gopaddi
//
//  Created by jizan k on 16/05/23.
//
import UIKit
import Fastis
import SDWebImage
protocol Category{
    func categorySelected(category: Int)
}
protocol CancelBooking{
    func bookingCancelled()
}
class BookingSelectionViewController: UIViewController, UITextFieldDelegate ,Category , CancelBooking{
    static let identifier = "BookingSelectionViewController"
    private let bookSelectTF: UITextField = {
        let field =  TextFieldWithPadding()
        field.layer.borderWidth = 0.1
        field.autocorrectionType = .yes
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 10
        field.textColor = .label
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.backgroundColor = .tertiarySystemBackground
        field.setupRightViewN(imageViewNamed: "down")
        field.placeholder = "Select booking"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let resultCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ActivityBookListTableViewCell.self, forCellReuseIdentifier: ActivityBookListTableViewCell.identifier)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var hotelBookList : [HotelBookListResult]?
    var activtyBookingList : [ActivityBookingListResult]?
    var option : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.reloadData()
        view.backgroundColor = .secondarySystemBackground
      title = "Booking"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Navigastion")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        view.addSubview(bookSelectTF)
        view.addSubview(resultCountLabel)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        bookSelectTF.delegate = self
    }
    private func callActivityBookingAPI(){
        view.showLoading()
        let userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
        ApiManager.shared.activityBookingList(userId: userId) { result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    if model.code == "200" {
                        self.view.stopLoading()
                        self.resultCountLabel.text = String(model.result?.count ?? 0) + " results found"
                        self.activtyBookingList = model.result
                        self.tableView.reloadData()
                    }else  if model.code == "404" {
                        self.view.stopLoading()
                        self.resultCountLabel.text = ""
                        let alert = UIAlertController(title: "", message: "Sorry No booking found!", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "Ok", style: .default){_ in
                            self.bookSelectTF.text = ""
                            self.bookSelectTF.placeholder = "Select booking"
                            alert.dismiss(animated: true)
                        }
                        alert.addAction(okBtn)
                        self.present(alert, animated: true)
                    }else
                    {
                        self.resultCountLabel.text = ""
                        self.view.stopLoading()
                    }
                }
            case .failure(let error):
                self.view.stopLoading()
                print(error.localizedDescription)
            }
        }
        self.view.stopLoading()

    }
    private func callHotelBookingAPI(){
        view.showLoading()
        let userId = UserDefaults.standard.string(forKey: "logkey") ?? ""
        ApiManager.shared.hotelBookedList(userId: userId){ result in
            switch result {
            case .success(let model) :
                DispatchQueue.main.async {
                    if model.code == "200" {
                        self.view.stopLoading()
                        self.resultCountLabel.text = String(model.result?.count ?? 0) + " results found"
                        self.hotelBookList = model.result
                        self.tableView.reloadData()
                    }else  if model.code == "404" {
                        self.view.stopLoading()
                        self.resultCountLabel.text = ""
                        let alert = UIAlertController(title: "", message: "Sorry No booking found!", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "Ok", style: .default){_ in
                            self.bookSelectTF.text = ""
                            self.bookSelectTF.placeholder = "Select booking"
                            alert.dismiss(animated: true)
                        }
                        alert.addAction(okBtn)
                        self.present(alert, animated: true)
                    }else
                    {
                        self.resultCountLabel.text = ""
                        self.view.stopLoading()
                    }
                }
            case .failure(let error):
                self.view.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
    @objc private func didTapBackButton() {
        self.dismiss(animated: true)
    }
    func bookingCancelled() {
        switch option {
        case 3: callActivityBookingAPI()
        case 4 : callHotelBookingAPI()
        default : print("Invalid")
        }
    }
    func categorySelected(category: Int) {
       
        switch category {
        case 3: self.bookSelectTF.text = "Activity Bookings"
            bookSelectTF.resignFirstResponder()
            option = 3
            callActivityBookingAPI()
           
        case 4 :
            self.bookSelectTF.text = "Hotel Bookings"
            bookSelectTF.resignFirstResponder()
            option = 4
            callHotelBookingAPI()
        default : print("Invalid")
        }
        self.tableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            bookSelectTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            bookSelectTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bookSelectTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bookSelectTF.heightAnchor.constraint(equalToConstant: 48),
            
            resultCountLabel.topAnchor.constraint(equalTo: bookSelectTF.bottomAnchor,constant: 20),
            resultCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            tableView.topAnchor.constraint(equalTo: resultCountLabel.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == bookSelectTF{
            self.bookSelectTF.resignFirstResponder()
            let vc = ActivityBookingSelectViewController()
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
}
extension BookingSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch option {
        case 3 : return  activtyBookingList?.count ?? 0
        case 4 : return  hotelBookList?.count ?? 0
        default : print("Invalid")
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityBookListTableViewCell.identifier, for: indexPath) as? ActivityBookListTableViewCell else {
            return UITableViewCell()
        }
        switch option {
        case 3 :  cell.configure(activityBookingList: activtyBookingList![indexPath.row])
            cell.didTap = {
                let vc = ActivityBookingDetailsViewController()
                vc.delegate = self
                vc.bookId = self.activtyBookingList![indexPath.row].acbId
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        case 4 :  cell.configureHotel(BookingList: hotelBookList![indexPath.row])
            cell.didTap = {
                let vc = HotelBookingDetailsViewController()
                vc.delegate = self
                vc.hotelBookList = self.hotelBookList![indexPath.row]
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        default : print("Invalid")
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

