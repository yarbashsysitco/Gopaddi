//
//  HotelPopUpViewController.swift
//  Gopaddi
//
//  Created by jizan k on 08/05/23.
//
import UIKit
import iOSDropDown
class HotelPopUpViewController: UIViewController , UITextFieldDelegate {
   
        @IBOutlet weak var r4ChildV3Width: NSLayoutConstraint!
        @IBOutlet weak var r4ChildV1Width: NSLayoutConstraint!
        @IBOutlet weak var r4InfoView: UIView!
        @IBOutlet weak var r4BtnView: UIView!
        @IBOutlet weak var r4ApplyBtn: UIView!
        @IBOutlet weak var r4EditBtn: UIButton!
        @IBOutlet weak var r4RemoveBtn: UIButton!
        @IBOutlet weak var r4AdultCount: UILabel!
        @IBOutlet weak var r4ChildCount: UILabel!
        @IBOutlet weak var r4AdultCountTF: DropDown!
        @IBOutlet weak var r4ChildCountTF: DropDown!
        @IBOutlet weak var r4Child1Age: DropDown!
        @IBOutlet weak var r4Child2Age: DropDown!
        @IBOutlet weak var r4Child3Age: DropDown!
        @IBOutlet weak var r4Child4Age: DropDown!
        @IBOutlet weak var r4CountView: UIView!
        @IBOutlet weak var r4ChildAgeV1: UIView!
        @IBOutlet weak var r4ChildAgeV2: UIView!
        @IBOutlet weak var r4ChildAgeV3: UIView!
        @IBOutlet weak var r4ChildAgeV4: UIView!
        @IBOutlet weak var r4InfoViewTop: NSLayoutConstraint!
        @IBOutlet weak var r4InfoViewHeight: NSLayoutConstraint!
        
        @IBOutlet weak var r3InfoView: UIView!
        @IBOutlet weak var r3BtnView: UIView!
        @IBOutlet weak var r3InfoViewHeight: NSLayoutConstraint!
        @IBOutlet weak var r3ChildV3Width: NSLayoutConstraint!
        @IBOutlet weak var r3ChildV1Width: NSLayoutConstraint!
        @IBOutlet weak var r3InfoViewTop: NSLayoutConstraint!
        @IBOutlet weak var r3ChildCount: UILabel!
        @IBOutlet weak var r3AdultCount: UILabel!
        @IBOutlet weak var r3ChildCountTF: DropDown!
        @IBOutlet weak var r3AdultCountTF: DropDown!
        @IBOutlet weak var r3Child2Age: DropDown!
        @IBOutlet weak var r3Child1Age: DropDown!
        @IBOutlet weak var r3Child4Age: DropDown!
        @IBOutlet weak var r3Child3Age: DropDown!
        @IBOutlet weak var r3RemoveBtn: UIButton!
        @IBOutlet weak var r3EditBtn: UIButton!
        @IBOutlet weak var r3CountView: UIView!
        @IBOutlet weak var r3ChildAgeV1: UIView!
        @IBOutlet weak var r3ChildAgeV2: UIView!
        @IBOutlet weak var r3ChildAgeV3: UIView!
        @IBOutlet weak var r3ChildAgeV4: UIView!
        @IBOutlet weak var r3ApplyBtn: UIButton!
        @IBOutlet weak var r3NewRBtn: UIButton!
        
        @IBOutlet weak var r2BtnView: UIView!
        @IBOutlet weak var ContentView: UIView!
        @IBOutlet weak var r2InfoView: UIView!
        @IBOutlet weak var r2InfoViewHeight: NSLayoutConstraint!
        @IBOutlet weak var r2ChildCount: UILabel!
        @IBOutlet weak var r2AdultCount: UILabel!
        @IBOutlet weak var r2ChildAgeV1: UIView!
        @IBOutlet weak var r2ChildAgeV3: UIView!
        @IBOutlet weak var r2ChildAgeV2: UIView!
        @IBOutlet weak var r2ChildAgeV4: UIView!
        @IBOutlet weak var r2ChildCountTF: DropDown!
        @IBOutlet weak var r2AdultCountTF: DropDown!
        @IBOutlet weak var r2Child1Age: DropDown!
        @IBOutlet weak var r2Child2Age: DropDown!
        @IBOutlet weak var r2Child3Age: DropDown!
        @IBOutlet weak var r2Child4Age: DropDown!
        @IBOutlet weak var r2RemoveBtn: UIButton!
        @IBOutlet weak var r2EditBtn: UIButton!
        @IBOutlet weak var r2ApplyBtn: UIButton!
        @IBOutlet weak var r2NewRBtn: UIButton!
        @IBOutlet weak var r2InfoViewTop: NSLayoutConstraint!
        @IBOutlet weak var r2ChildV1Width: NSLayoutConstraint!
        @IBOutlet weak var r2CountView: UIView!
        @IBOutlet weak var r2ChildV3Width: NSLayoutConstraint!
        
        @IBOutlet weak var r1ChildCountTF: DropDown!
        @IBOutlet weak var r1AdultCountTF: DropDown!
        @IBOutlet weak var r1EditBtn: UIButton!
        @IBOutlet weak var r1InfoView: UIView!
        @IBOutlet weak var r1InfoViewHeight: NSLayoutConstraint!
        @IBOutlet weak var r1ChildrenCount: UILabel!
        @IBOutlet weak var r1AdultsCount: UILabel!
        @IBOutlet weak var r1BtnView: UIView!
        @IBOutlet var r1BackView: UIView!
        @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
        @IBOutlet weak var r1ChildV1Width: NSLayoutConstraint!
        @IBOutlet weak var r1ChildV3Width: NSLayoutConstraint!
        @IBOutlet weak var r1Child1Age: DropDown!
        @IBOutlet weak var r1Child2Age: DropDown!
        @IBOutlet weak var r1Child3Age: DropDown!
        @IBOutlet weak var r1Child4Age: DropDown!
        @IBOutlet weak var r1Child1View: UIView!
        @IBOutlet weak var r1Child2View: UIView!
        @IBOutlet weak var r1Child3View: UIView!
        @IBOutlet weak var r1Child4View: UIView!
        @IBOutlet weak var r1ApplyBtn: UIButton!
        @IBOutlet weak var r1NewRBtn: UIButton!
        @IBOutlet weak var r1CountView: UIView!
        var childCount = ["0","1","2","3","4"]
        let adultCount = ["1","2","3","4"]
        let childAge = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        var roomCount : Int = 1
        var delegate : PInfo?
        var childAge1 : Int = 12
        var childAge2 : Int = 12
        var childAge3 : Int = 12
        var childAge4 : Int = 12
        
        var occupancyFinalList : [Occupancy] = []
        var dictionary:[String:Any] = [String: Any]()
        var occupancyFinalList1 : [Any] = []
        override func viewDidLoad() {
            super.viewDidLoad()
            r1BackView.backgroundColor = .clear
            ContentView.alpha = 2
            dropDownSetUp()
            borderSetUp()
            initSetUp()
            room1SetUp()
            room2SetUp()
            room3SetUp()
            room4SetUp()
        }
        func initSetUp(){
            r1Child1View.isHidden = true
            r1Child2View.isHidden = true
            r1Child3View.isHidden = true
            r1Child4View.isHidden = true
            r1EditBtn.isHidden = true
            r2InfoView.isHidden = true
            r3InfoView.isHidden = true
            r3BtnView.isHidden = true
            r4InfoView.isHidden = true
            r4BtnView.isHidden = true
            r1InfoViewHeight.constant = 190
            r2InfoViewHeight.constant = 0
            r3InfoViewHeight.constant = 0
            r4InfoViewHeight.constant = 0
            r2BtnView.isHidden = true
            contentViewHeight.constant = 265
        }
        private func borderSetUp(){
            r1InfoView.layer.borderWidth = 1
            r1InfoView.layer.borderColor = UIColor.systemGray.cgColor
            r1InfoView.layer.cornerRadius = 10
            r2InfoView.layer.borderWidth = 1
            r2InfoView.layer.borderColor = UIColor.systemGray.cgColor
            r2InfoView.layer.cornerRadius = 10
            r3InfoView.layer.borderWidth = 1
            r3InfoView.layer.borderColor = UIColor.systemGray.cgColor
            r3InfoView.layer.cornerRadius = 10
            r4InfoView.layer.borderWidth = 1
            r4InfoView.layer.borderColor = UIColor.systemGray.cgColor
            r4InfoView.layer.cornerRadius = 10
            r1NewRBtn.layer.borderWidth = 1
            r1NewRBtn.layer.borderColor = UIColor.systemGray.cgColor
            r1NewRBtn.layer.cornerRadius = 10
            r1ApplyBtn.layer.cornerRadius = 10
            r2NewRBtn.layer.borderWidth = 1
            r2NewRBtn.layer.borderColor = UIColor.systemGray.cgColor
            r2NewRBtn.layer.cornerRadius = 10
            r2ApplyBtn.layer.cornerRadius = 10
            r3NewRBtn.layer.borderWidth = 1
            r3NewRBtn.layer.borderColor = UIColor.systemGray.cgColor
            r3NewRBtn.layer.cornerRadius = 10
            r3ApplyBtn.layer.cornerRadius = 10
            r4ApplyBtn.layer.cornerRadius = 10
        }
        private func dropDownSetUp(){
            r1AdultCountTF.optionArray = adultCount
            r1ChildCountTF.optionArray = childCount
            r2ChildCountTF.optionArray = childCount
            r2AdultCountTF.optionArray = adultCount
            r3ChildCountTF.optionArray = childCount
            r3AdultCountTF.optionArray = adultCount
            r4ChildCountTF.optionArray = childCount
            r4AdultCountTF.optionArray = adultCount
            r2Child1Age.optionArray = childAge
            r2Child2Age.optionArray = childAge
            r2Child3Age.optionArray = childAge
            r2Child4Age.optionArray = childAge
            r1Child1Age.optionArray = childAge
            r1Child2Age.optionArray = childAge
            r1Child3Age.optionArray = childAge
            r1Child4Age.optionArray = childAge
            r3Child1Age.optionArray = childAge
            r3Child2Age.optionArray = childAge
            r3Child3Age.optionArray = childAge
            r3Child4Age.optionArray = childAge
            r4Child1Age.optionArray = childAge
            r4Child2Age.optionArray = childAge
            r4Child3Age.optionArray = childAge
            r4Child4Age.optionArray = childAge
        }
        private func room1SetUp(){
            r1AdultCountTF.didSelect{(selectedText , index ,id) in
                self.r1AdultsCount.text = selectedText
                self.r1AdultsCount.text = selectedText
            }
            r1ChildCountTF.didSelect{(selectedText , index ,id) in
                self.r1ChildrenCount.text = selectedText
                self.r1ChildCountTF.text = selectedText
                if self.r1ChildCountTF.text == "0" {
                    self.room1ChildViewInit()
                    self.r1InfoViewHeight.constant = 190
                    self.r1ChildV1Width.constant = 146
                    self.r1ChildV3Width.constant = 146
                    self.setContentViewHeight()
                }
                else if self.r1ChildCountTF.text == "1" {
                    self.r1Child2View.isHidden = true
                    self.r1Child3View.isHidden = true
                    self.r1Child4View.isHidden = true
                    self.r1Child1View.isHidden = false
                    self.r1InfoViewHeight.constant = 275
                    self.setContentViewHeight()
                    self.r1ChildV3Width.constant = 146
                    self.r1ChildV1Width.constant = self.r1InfoView.frame.size.width - 8
                }
                else if self.r1ChildCountTF.text == "2" {
                    self.r1Child1View.isHidden = false
                    self.r1Child2View.isHidden = false
                    self.r1Child3View.isHidden = true
                    self.r1Child4View.isHidden = true
                    self.r1InfoViewHeight.constant = 275
                    self.setContentViewHeight()
                    self.r1ChildV1Width.constant = 146
                    self.r1ChildV3Width.constant = 146
                }
                else if self.r1ChildCountTF.text == "3" {
                    self.r1Child1View.isHidden = false
                    self.r1Child2View.isHidden = false
                    self.r1Child3View.isHidden = false
                    self.r1Child4View.isHidden = true
                    self.r1InfoViewHeight.constant = 368
                    self.setContentViewHeight()
                    self.r1ChildV1Width.constant = 146
                    self.r1ChildV3Width.constant = self.r1InfoView.frame.size.width - 8
                }
                else if self.r1ChildCountTF.text == "4" {
                    self.r1Child1View.isHidden = false
                    self.r1Child2View.isHidden = false
                    self.r1Child3View.isHidden = false
                    self.r1Child4View.isHidden = false
                    self.r1InfoViewHeight.constant = 368
                    self.setContentViewHeight()
                    self.r1ChildV1Width.constant = 146
                    self.r1ChildV3Width.constant = 146
                }
            }
        }
        
        private func room2SetUp(){
            r2AdultCountTF.didSelect{(selectedText , index ,id) in
                self.r2AdultCount.text = selectedText
                self.r2AdultCountTF.text = selectedText
            }
            r2ChildCountTF.didSelect{(selectedText , index ,id) in
                self.r2ChildCount.text = selectedText
                self.r2ChildCountTF.text = selectedText
                if self.r2ChildCountTF.text == "0" {
                    self.room2ChildViewInit()
                    self.r2InfoViewHeight.constant = 190
                    self.setContentViewHeight()
                    self.r2ChildV1Width.constant = 146
                    self.r2ChildV3Width.constant = 146
                }
                else if self.r2ChildCountTF.text == "1" {
                    self.r2ChildAgeV1.isHidden = false
                    self.r2ChildAgeV2.isHidden = true
                    self.r2ChildAgeV3.isHidden = true
                    self.r2ChildAgeV4.isHidden = true
                    self.r2InfoViewHeight.constant = 278
                    self.setContentViewHeight()
                    self.r2ChildV1Width.constant = self.r2InfoView.frame.size.width - 8
                    self.r2ChildV3Width.constant = 146
                }
                else if self.r2ChildCountTF.text == "2" {
                    self.r2ChildAgeV1.isHidden = false
                    self.r2ChildAgeV2.isHidden = false
                    self.r2ChildAgeV3.isHidden = true
                    self.r2ChildAgeV4.isHidden = true
                    self.r2InfoViewHeight.constant = 278
                    self.setContentViewHeight()
                    self.r2ChildV1Width.constant = 146
                    self.r2ChildV3Width.constant = 146
                }
                else if self.r2ChildCountTF.text == "3" {
                    self.r2ChildAgeV1.isHidden = false
                    self.r2ChildAgeV2.isHidden = false
                    self.r2ChildAgeV3.isHidden = false
                    self.r2ChildAgeV4.isHidden = true
                    self.r2InfoViewHeight.constant = 370
                    self.setContentViewHeight()
                    self.r2ChildV1Width.constant = 146
                    self.r2ChildV3Width.constant = self.r2InfoView.frame.size.width - 8
                }
                else if self.r2ChildCountTF.text == "4" {
                    self.r2ChildAgeV1.isHidden = false
                    self.r2ChildAgeV2.isHidden = false
                    self.r2ChildAgeV3.isHidden = false
                    self.r2ChildAgeV4.isHidden = false
                    self.r2InfoViewHeight.constant = 370
                    self.setContentViewHeight()
                    self.r2ChildV1Width.constant = 146
                    self.r2ChildV3Width.constant = 146
                }
            }
        }
        private func room3SetUp(){
            r3AdultCountTF.didSelect{(selectedText , index ,id) in
                self.r3AdultCount.text = selectedText
                self.r3AdultCountTF.text = selectedText
            }
            r3ChildCountTF.didSelect{(selectedText , index ,id) in
                self.r3ChildCount.text = selectedText
                self.r3ChildCountTF.text = selectedText
                if self.r3ChildCountTF.text == "0" {
                    self.room3ChildViewInit()
                    self.r3InfoViewHeight.constant = 190
                    self.setContentViewHeight()
                    self.r3ChildV1Width.constant = 146
                    self.r3ChildV3Width.constant = 146
                }
                else if self.r3ChildCountTF.text == "1" {
                    self.r3ChildAgeV1.isHidden = false
                    self.r3ChildAgeV2.isHidden = true
                    self.r3ChildAgeV3.isHidden = true
                    self.r3ChildAgeV4.isHidden = true
                    self.r3InfoViewHeight.constant = 278
                    self.setContentViewHeight()
                    self.r3ChildV1Width.constant = self.r3InfoView.frame.size.width - 8
                    self.r3ChildV3Width.constant = 146
                }
                else if self.r3ChildCountTF.text == "2" {
                    self.r3ChildAgeV1.isHidden = false
                    self.r3ChildAgeV2.isHidden = false
                    self.r3ChildAgeV3.isHidden = true
                    self.r3ChildAgeV4.isHidden = true
                    self.r3InfoViewHeight.constant = 278
                    self.setContentViewHeight()
                    self.r3ChildV1Width.constant = 146
                    self.r3ChildV3Width.constant = 146
                }
                else if self.r3ChildCountTF.text == "3" {
                    self.r3ChildAgeV1.isHidden = false
                    self.r3ChildAgeV2.isHidden = false
                    self.r3ChildAgeV3.isHidden = false
                    self.r3ChildAgeV4.isHidden = true
                    self.r3InfoViewHeight.constant = 370
                    self.setContentViewHeight()
                    self.r3ChildV1Width.constant = 146
                    self.r3ChildV3Width.constant = self.r3InfoView.frame.size.width - 8
                }
                else if self.r3ChildCountTF.text == "4" {
                    self.r3ChildAgeV1.isHidden = false
                    self.r3ChildAgeV2.isHidden = false
                    self.r3ChildAgeV3.isHidden = false
                    self.r3ChildAgeV4.isHidden = false
                    self.r3InfoViewHeight.constant = 370
                    self.setContentViewHeight()
                    self.r3ChildV1Width.constant = 146
                    self.r3ChildV3Width.constant = 146
                }
            }
        }
        
        private func room4SetUp(){
            r4AdultCountTF.didSelect{(selectedText , index ,id) in
                self.r4AdultCount.text = selectedText
                self.r4AdultCountTF.text = selectedText
            }
            r4ChildCountTF.didSelect{(selectedText , index ,id) in
                self.r4ChildCount.text = selectedText
                self.r4ChildCountTF.text = selectedText
                if self.r4ChildCountTF.text == "0" {
                    self.room4ChildViewInit()
                    self.r4InfoViewHeight.constant = 190
                    self.setContentViewHeight()
                    self.r4ChildV1Width.constant = 146
                    self.r4ChildV3Width.constant = 146
                }
                else if self.r4ChildCountTF.text == "1" {
                    self.r4ChildAgeV1.isHidden = false
                    self.r4ChildAgeV2.isHidden = true
                    self.r4ChildAgeV3.isHidden = true
                    self.r4ChildAgeV4.isHidden = true
                    self.r4InfoViewHeight.constant = 278
                    self.setContentViewHeight()
                    self.r4ChildV1Width.constant = self.r4InfoView.frame.size.width - 8
                    self.r4ChildV3Width.constant = 146
                    
                }
                else if self.r4ChildCountTF.text == "2" {
                    self.r4ChildAgeV1.isHidden = false
                    self.r4ChildAgeV2.isHidden = false
                    self.r4ChildAgeV3.isHidden = true
                    self.r4ChildAgeV4.isHidden = true
                    self.r4InfoViewHeight.constant = 278
                    self.setContentViewHeight()
                    self.r4ChildV1Width.constant = 146
                    self.r4ChildV3Width.constant = 146
                }
                else if self.r4ChildCountTF.text == "3" {
                    self.r4ChildAgeV1.isHidden = false
                    self.r4ChildAgeV2.isHidden = false
                    self.r4ChildAgeV3.isHidden = false
                    self.r4ChildAgeV4.isHidden = true
                    self.r4InfoViewHeight.constant = 370
                    self.setContentViewHeight()
                    self.r4ChildV1Width.constant = 146
                    self.r4ChildV3Width.constant = self.r4InfoView.frame.size.width - 8
                }
                else if self.r4ChildCountTF.text == "4" {
                    self.r4ChildAgeV1.isHidden = false
                    self.r4ChildAgeV2.isHidden = false
                    self.r4ChildAgeV3.isHidden = false
                    self.r4ChildAgeV4.isHidden = false
                    self.r4InfoViewHeight.constant = 370
                    self.setContentViewHeight()
                    self.r4ChildV1Width.constant = 146
                    self.r4ChildV3Width.constant = 146
                }
            }
        }
        
        @IBAction func didTapNewRoom(_ sender: UIButton) {
            if sender.tag == 1{
                roomCount += 1
                r2CountView.isHidden = false
                r1InfoViewHeight.constant = 80
                r2InfoViewTop.constant = 0
                r2InfoViewHeight.constant = 190
                r2InfoView.isHidden = false
                r1BtnView.isHidden = true
                r2BtnView.isHidden = false
                room1ChildViewInit()
                room2ChildViewInit()
                r1EditBtn.isHidden = false
                r2EditBtn.isHidden = true
                r2RemoveBtn.isHidden = false
                self.setContentViewHeight()
            }
            else if sender.tag == 2 {
                roomCount += 1
                r3CountView.isHidden = false
                r1EditBtn.isHidden = false
                r2EditBtn.isHidden = false
                r2RemoveBtn.isHidden = true
                r3EditBtn.isHidden = true
                r3RemoveBtn.isHidden = false
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 80
                r2InfoViewTop.constant = 0
                r3InfoViewTop.constant = 0
                r2InfoView.isHidden = false
                r3InfoView.isHidden = false
                r3InfoViewHeight.constant = 190
                r1BtnView.isHidden = true
                r2BtnView.isHidden = true
                r3BtnView.isHidden = false
                room1ChildViewInit()
                room2ChildViewInit()
                room3ChildViewInit()
                self.setContentViewHeight()
            }
            else if sender.tag == 3 {
                roomCount += 1
                r4CountView.isHidden = false
                r1EditBtn.isHidden = false
                r2EditBtn.isHidden = false
                r3EditBtn.isHidden = false
                r4EditBtn.isHidden = true
                r2RemoveBtn.isHidden = true
                r3RemoveBtn.isHidden = true
                r4RemoveBtn.isHidden = false
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 80
                r3InfoViewHeight.constant = 80
                r2InfoViewTop.constant = 0
                r3InfoViewTop.constant = 0
                r4InfoViewTop.constant = 0
                r2InfoView.isHidden = false
                r3InfoView.isHidden = false
                r4InfoView.isHidden = false
                r4InfoViewHeight.constant = 190
                r1BtnView.isHidden = true
                r2BtnView.isHidden = true
                r3BtnView.isHidden = true
                r4BtnView.isHidden = false
                room2ChildViewInit()
                room3ChildViewInit()
                room4ChildViewInit()
                self.setContentViewHeight()
            }
        }
        
        @IBAction func didTapApplyBtn(_ sender: Any) {
            occupancyFinalList.removeAll()
            var finalAdultC : Int?
            var finalChildC : Int?
            switch ((sender as AnyObject).tag){
            case 1 : let occupancy1 = room1FinalSet()
                finalAdultC = occupancy1.adult
                finalChildC = occupancy1.child
                setUPList(occupancy: occupancy1)
                
            case 2 : let occupancy1 = room1FinalSet()
                setUPList(occupancy: occupancy1)
                let occupancy2 =  room2FinalSet()
                setUPList(occupancy: occupancy2)
                finalAdultC = occupancy1.adult + occupancy2.adult
               
                finalChildC = occupancy1.child + occupancy2.child
                
            case 3 : let occupancy1 = room1FinalSet()
                setUPList(occupancy: occupancy1)
                let occupancy2 = room2FinalSet()
                setUPList(occupancy: occupancy2)
                let occupancy3 = room3FinalSet()
                setUPList(occupancy: occupancy3)
                finalAdultC = occupancy1.adult + occupancy2.adult + occupancy3.adult
                finalChildC = occupancy1.child + occupancy2.child + occupancy3.child
                occupancyFinalList = [occupancy1 ,occupancy2, occupancy3]
            case 4 : let occupancy1 = room1FinalSet()
                setUPList(occupancy: occupancy1)
                let occupancy2 = room2FinalSet()
                setUPList(occupancy: occupancy2)
                let occupancy3 = room3FinalSet()
                setUPList(occupancy: occupancy3)
                let occupancy4 = room4FinalSet()
                setUPList(occupancy: occupancy4)
                finalAdultC = occupancy1.adult + occupancy2.adult + occupancy3.adult + occupancy4.adult
                finalChildC = occupancy1.child + occupancy2.child + occupancy3.child + occupancy4.child
            default : print("Invalid")
            }
            delegate?.clientDetails(occupancy: occupancyFinalList1 , roomC : roomCount ,childC : finalChildC! , adultNo : finalAdultC!)
            self.dismiss(animated: true)
        }
        func setUPList(occupancy : Occupancy) {
            do {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(occupancy)
                let jsonString = String(data: jsonData, encoding: .utf8)
                let jsonData1 = (jsonString?.data(using: .utf8))!
                let json = try JSONSerialization.jsonObject(with: jsonData1, options: [])
                occupancyFinalList1.append(json)
                
            }catch let error{
                print(error.localizedDescription)
            }
            
        }
        func room1FinalSet() -> Occupancy{
            childAge1 = Int(r1Child1Age.text ?? "12")!
            childAge2 = Int(r1Child2Age.text ?? "12")!
            childAge3 = Int(r1Child3Age.text ?? "12")!
            childAge4 = Int(r1Child4Age.text ?? "12")!
            var ageList : [Int] = [0]
            let childCount = Int(r1ChildrenCount.text ?? "0")!
            ageList = [childAge1,childAge2,childAge3,childAge4]
            ageList = getChildrenAges(childCount: childCount, list: ageList)
            let occupancyList = Occupancy(room_no: 1, adult: Int(r1AdultsCount.text ?? "1")!, child: Int(r1ChildrenCount.text ?? "0")!, child_age: ageList)
            return occupancyList
        }
        func room2FinalSet() -> Occupancy{
            childAge1 = Int(r2Child1Age.text ?? "12")!
            childAge2 = Int(r2Child2Age.text ?? "12")!
            childAge3 = Int(r2Child3Age.text ?? "12")!
            childAge4 = Int(r2Child4Age.text ?? "12")!
            var occupancyList : Occupancy?
            var ageList : [Int] = [childAge1,childAge2,childAge3,childAge4]
            let childCount = Int(r2ChildCount.text ?? "0")!
            ageList = getChildrenAges(childCount: childCount, list: ageList)
            occupancyList = Occupancy(room_no: 2, adult: Int(r2AdultCount.text ?? "1")!, child: Int(r2ChildCount.text ?? "0")!, child_age: ageList)
            return occupancyList!
        }
        func room3FinalSet() -> Occupancy{
            childAge1 = Int(r3Child1Age.text ?? "12")!
            childAge2 = Int(r3Child2Age.text ?? "12")!
            childAge3 = Int(r3Child3Age.text ?? "12")!
            childAge4 = Int(r3Child4Age.text ?? "12")!
            var occupancyList : Occupancy?
            var ageList : [Int] = [childAge1,childAge2,childAge3,childAge4]
            let childCount = Int(r3ChildCount.text ?? "0")!
            ageList = getChildrenAges(childCount: childCount, list: ageList)
            occupancyList = Occupancy(room_no: 3, adult: Int(r3AdultCount.text ?? "1")!, child: Int(r3ChildCount.text ?? "0")!, child_age: ageList)
            return occupancyList!
        }
        func room4FinalSet() -> Occupancy{
            childAge1 = Int(r4Child1Age.text ?? "12")!
            childAge2 = Int(r4Child2Age.text ?? "12")!
            childAge3 = Int(r4Child3Age.text ?? "12")!
            childAge4 = Int(r4Child4Age.text ?? "12")!
            var occupancyList : Occupancy?
            var ageList : [Int] = [childAge1,childAge2,childAge3,childAge4]
            let childCount = Int(r4ChildCount.text ?? "0")!
            ageList = getChildrenAges(childCount: childCount, list: ageList)
            occupancyList = Occupancy(room_no: 4, adult: Int(r4AdultCount.text ?? "1")!, child: Int(r4ChildCount.text ?? "0")!, child_age: ageList)
            return occupancyList!
        }
        
        func getChildrenAges(childCount : Int , list : [Int?]) -> [Int] {
            var childrenAge : [Int] = []
            if childCount != 0 {
                for i in 0...childCount - 1  {
                    childrenAge.append(list[i] ?? 12)
                }
            }
            return childrenAge
        }
        
        @IBAction func didTapEditBtn(_ sender: UIButton) {
            switch sender.tag {
            case 1 :
                r1BtnView.isHidden = true
                r1CountView.isHidden = false
                r2CountView.isHidden = true
                r3CountView.isHidden = true
                r4CountView.isHidden = true
                self.room1ChildViewInit()
                self.room2ChildViewInit()
                self.room3ChildViewInit()
                self.room4ChildViewInit()
                r1InfoViewHeight.constant = 190
                if roomCount > 1{
                    r2InfoViewHeight.constant = 80
                }
                if roomCount > 2{
                    r3InfoViewHeight.constant = 80
                }
                if roomCount > 3{
                    r4InfoViewHeight.constant = 80
                }
                r1EditBtn.isHidden = true
                r3EditBtn.isHidden = false
                r2EditBtn.isHidden = false
                r4EditBtn.isHidden = false
                r2RemoveBtn.isHidden = true
                r4RemoveBtn.isHidden = true
                r4CountView.isHidden = true
                r3CountView.isHidden = true
                self.setContentViewHeight()
            case 2:
                self.room1ChildViewInit()
                self.room2ChildViewInit()
                self.room3ChildViewInit()
                self.room4ChildViewInit()
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 190
                if roomCount > 2 {
                    r3InfoViewHeight.constant = 80
                }
                if roomCount > 3 {
                    r4InfoViewHeight.constant = 80
                }
                r1EditBtn.isHidden = false
                r2EditBtn.isHidden = true
                r3EditBtn.isHidden = false
                r4EditBtn.isHidden = false
                r1CountView.isHidden = true
                r2CountView.isHidden = false
                r3CountView.isHidden = true
                r4CountView.isHidden = true
                r3InfoView.isHidden = false
                r4EditBtn.isHidden = false
                r3RemoveBtn.isHidden = true
                r4RemoveBtn.isHidden = true
                self.setContentViewHeight()
            case 3 :
                self.room1ChildViewInit()
                self.room2ChildViewInit()
                self.room3ChildViewInit()
                self.room4ChildViewInit()
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 80
                r3InfoViewHeight.constant = 190
                if roomCount > 3 {
                    r4InfoViewHeight.constant = 80
                }
                r3EditBtn.isHidden = true
                r2EditBtn.isHidden = false
                r1EditBtn.isHidden = false
                r4EditBtn.isHidden = false
                r4RemoveBtn.isHidden = true
                r1CountView.isHidden = true
                r2CountView.isHidden = true
                r3CountView.isHidden = false
                r4CountView.isHidden = true
                self.setContentViewHeight()
            case 4 :
                self.room1ChildViewInit()
                self.room2ChildViewInit()
                self.room3ChildViewInit()
                self.room4ChildViewInit()
                r1EditBtn.isHidden = false
                r2EditBtn.isHidden = false
                r3EditBtn.isHidden = false
                r4EditBtn.isHidden = true
                r4RemoveBtn.isHidden = false
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 80
                r3InfoViewHeight.constant = 80
                r4InfoViewHeight.constant = 190
                r1CountView.isHidden = true
                r2CountView.isHidden = true
                r3CountView.isHidden = true
                r4CountView.isHidden = false
                r4InfoView.isHidden = false
                self.setContentViewHeight()
            default:
                print("Invalid")
            }
        }
        @IBAction func didTapRemoveBtn(_ sender: UIButton) {
            if sender.tag == 2 {
                roomCount -= 1
                r1CountView.isHidden = false
                r2CountView.isHidden = true
                r3CountView.isHidden = true
                r4CountView.isHidden = true
                room1ChildViewInit()
                r1EditBtn.isHidden = true
                r2InfoView.isHidden = true
                r1InfoViewHeight.constant = 190
                r2InfoViewHeight.constant = 0
                r2BtnView.isHidden = true
                r1BtnView.isHidden = false
                self.setContentViewHeight()
                r2ChildCount.text = "0"
                r2ChildCountTF.text = "0"
                r2AdultCount.text = "1"
                r2AdultCountTF.text = "1"
            }
            if sender.tag == 3{
                roomCount -= 1
                room2ChildViewInit()
                r1CountView.isHidden = true
                r2CountView.isHidden = false
                r3CountView.isHidden = true
                r4CountView.isHidden = true
                r2EditBtn.isHidden = true
                r2RemoveBtn.isHidden = false
                r3InfoView.isHidden = true
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 190
                r3InfoViewHeight.constant = 0
                r3BtnView.isHidden = true
                r2BtnView.isHidden = false
                self.setContentViewHeight()
                r3ChildCount.text = "0"
                r3ChildCountTF.text = "0"
                r3AdultCount.text = "1"
                r3AdultCountTF.text = "1"
            }
            if sender.tag == 4 {
                roomCount -= 1
                r1CountView.isHidden = true
                r2CountView.isHidden = true
                r3CountView.isHidden = false
                r4CountView.isHidden = true
                room3ChildViewInit()
                r3EditBtn.isHidden = true
                r3RemoveBtn.isHidden = false
                r4InfoView.isHidden = true
                r1InfoViewHeight.constant = 80
                r2InfoViewHeight.constant = 80
                r3InfoViewHeight.constant = 190
                r4InfoViewHeight.constant = 0
                r4BtnView.isHidden = true
                r3BtnView.isHidden = false
                self.setContentViewHeight()
                r4ChildCount.text = "0"
                r4ChildCountTF.text = "0"
                r4AdultCount.text = "1"
                r4AdultCountTF.text = "1"
            }
        }
        private func setContentViewHeight(){
            contentViewHeight.constant = r1InfoViewHeight.constant + r2InfoViewHeight.constant + r3InfoViewHeight.constant + r4InfoViewHeight.constant + 78
        }
        private func room1ChildViewInit(){
            r1Child1View.isHidden = true
            r1Child2View.isHidden = true
            r1Child3View.isHidden = true
            r1Child4View.isHidden = true
        }
        private func room2ChildViewInit(){
            r2ChildAgeV1.isHidden = true
            r2ChildAgeV2.isHidden = true
            r2ChildAgeV3.isHidden = true
            r2ChildAgeV4.isHidden = true
        }
        private func room3ChildViewInit(){
            r3ChildAgeV1.isHidden = true
            r3ChildAgeV2.isHidden = true
            r3ChildAgeV3.isHidden = true
            r3ChildAgeV4.isHidden = true
        }
        private func room4ChildViewInit(){
            r4ChildAgeV1.isHidden = true
            r4ChildAgeV2.isHidden = true
            r4ChildAgeV3.isHidden = true
            r4ChildAgeV4.isHidden = true
        }
    }
