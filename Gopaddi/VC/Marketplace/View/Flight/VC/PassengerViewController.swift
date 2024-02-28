//
//  PassengerViewController.swift
//  Gopaddi
//
//  Created by jizan k on 29/05/23.
//

import UIKit
import iOSDropDown

class PassengerViewController: UIViewController {

                    @IBOutlet var backView: UIView!
                    @IBOutlet weak var r1ChildCountTF: DropDown!
                    @IBOutlet weak var r1AdultCountTF: DropDown!
                    @IBOutlet weak var r1Set1View: UIView!
                    @IBOutlet weak var r1Set2View: UIView!
                    @IBOutlet weak var r1Set1ViewHeight: NSLayoutConstraint!
                    @IBOutlet weak var r1Set2ViewHeight: NSLayoutConstraint!
                    
                    @IBOutlet weak var r1InfoViewHeight: NSLayoutConstraint!
                    @IBOutlet weak var r1Child1Age: DropDown!
                    @IBOutlet weak var r1Child2Age: DropDown!
                    @IBOutlet weak var r1Child3Age: DropDown!
                    @IBOutlet weak var r1Child4Age: DropDown!
                    @IBOutlet weak var r1Child1View: UIView!
                    @IBOutlet weak var r1Child2View: UIView!
                    @IBOutlet weak var r1Child3View: UIView!
                    @IBOutlet weak var r1Child4View: UIView!
                    
                    @IBOutlet weak var infantsCount: DropDown!
                    @IBOutlet weak var doneBtn: UIButton!
                    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
                    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
                    let childCount = ["0","1","2","3","4","5","6","7","8","9","10"]
                    let infantsCounts = ["0","1","2","3","4","5","6","7","8","9","10"]
                    let adultCount = ["1","2","3","4","5","6","7","8","9","10"]
                    let childAge = ["1","2","3","4","5","6","7","8","9","10","11","12"]
                    var occupancyFinalList : [Occupancy] = []
                    var occupancyFinalList1 : [Any] = []
                    var delegate : PassengerInfo?
                    override func viewDidLoad() {
                        super.viewDidLoad()
                        backView.backgroundColor = .clear
                        dropDownSetUp()
                        initSetUp()
                        room1SetUp()
                    }
                    func initSetUp(){
                        self.r1InfoViewHeight.constant = 500
//                        self.r1Set1View.isHidden = true
//                        self.r1Set2View.isHidden = true
//                        self.scrollViewHeight.constant = 300
                        self.setScrollContentHeight()
//                        self.setUpRoom1View()
                        
                        self.r1InfoViewHeight.constant = 400
                        doneBtn.cornerR = 10

                    }
                    func setScrollContentHeight(){
//                        self.contentViewHeight.constant = self.r1InfoViewHeight.constant + 60
//                        if self.contentViewHeight.constant < 750 {
//                            self.scrollViewHeight.constant = self.contentViewHeight.constant
//                        }else {
                            self.scrollViewHeight.constant = 350
//                        }
                    }
                    private func dropDownSetUp(){
                        r1AdultCountTF.optionArray = adultCount
                        r1ChildCountTF.optionArray = childCount
                        infantsCount.optionArray = infantsCounts
                        
//                        r1Child1Age.optionArray = childAge
//                        r1Child2Age.optionArray = childAge
//                        r1Child3Age.optionArray = childAge
//                        r1Child4Age.optionArray = childAge
                    }
                    private func room1SetUp(){
                        r1AdultCountTF.didSelect{(selectedText , index ,id) in
                            self.r1AdultCountTF.text = selectedText
                        }
                        r1ChildCountTF.didSelect{(selectedText , index ,id) in
                            self.r1ChildCountTF.text = selectedText
//                            self.setUpRoom1View()
                        }
                    }
          
//                    func setUpRoom1View(){
//                        switch self.r1ChildCountTF.text {
//                        case "0" :
//                                self.room1ChildViewInit()
////                                self.r1Set1View.isHidden = true
////                                self.r1Set2View.isHidden = true
//                                self.r1InfoViewHeight.constant = 165
//                                self.setScrollContentHeight()
//                        case "1" :
//                                self.room1ChildViewInit()
////                                self.r1Set1View.isHidden = false
////                                self.r1Set2View.isHidden = true
////                                self.r1Child1View.isHidden = false
////                                self.r1Child2View.isHidden = true
//                                self.r1InfoViewHeight.constant = 260
//                                self.setScrollContentHeight()
//                        case "2" :
//                                self.room1ChildViewInit()
////                                self.r1Set1View.isHidden = false
////                                self.r1Set2View.isHidden = true
////                                self.r1Child1View.isHidden = false
////                                self.r1Child2View.isHidden = false
//                                self.r1InfoViewHeight.constant = 260
//                                self.setScrollContentHeight()
//                        case "3" :
//                                self.room1ChildViewInit()
////                                self.r1Set1View.isHidden = false
////                                self.r1Set2View.isHidden = false
////                                self.r1Child1View.isHidden = false
////                                self.r1Child2View.isHidden = false
////                                self.r1Child3View.isHidden = false
//                                self.r1Child4View.isHidden = true
//                                self.r1InfoViewHeight.constant = 315
//                                self.setScrollContentHeight()
//                        case "4" :
//                                self.room1ChildViewInit()
////                                self.r1Set1View.isHidden = false
////                                self.r1Set2View.isHidden = false
////                                self.r1Child1View.isHidden = false
////                                self.r1Child2View.isHidden = false
////                                self.r1Child3View.isHidden = false
////                                self.r1Child4View.isHidden = false
//                                self.r1InfoViewHeight.constant = 315
//                                self.setScrollContentHeight()
//                        default : print("Invalid")
//                        }
//                        self.setScrollContentHeight()
//                    }
                    @IBAction func didTapClose(_ sender: Any) {
                        self.dismiss(animated: true)
                    }
                    private func setContentViewHeight(){
                        contentViewHeight.constant = r1InfoViewHeight.constant + 78
                    }
                    private func room1ChildViewInit(){
//                        r1Child1View.isHidden = true
//                        r1Child2View.isHidden = true
//                        r1Child3View.isHidden = true
//                        r1Child4View.isHidden = true
                    }
                    @IBAction func didTapApplyBtn(_ sender: Any) {
                        occupancyFinalList.removeAll()
//                        let ageListed = room1FinalSet()
                            let finalAdultC = self.r1AdultCountTF.text ?? "1"
                            let finalChildC = self.r1ChildCountTF.text ?? "0"
                            let finalinfants = self.infantsCount.text ?? "0"
                        delegate?.passengerCount(adultC: finalAdultC, childC: finalChildC, infantsc: finalinfants)
                       
                        self.dismiss(animated: true)
                    }
//                    func room1FinalSet() -> [Int]{
////                        let childAge1 = Int(r1Child1Age.text ?? "12")!
////                        let childAge2 = Int(r1Child2Age.text ?? "12")!
////                        let childAge3 = Int(r1Child3Age.text ?? "12")!
////                        let childAge4 = Int(r1Child4Age.text ?? "12")!
//                        var ageList : [Int] = [0]
//                        let childCount = Int(r1ChildCountTF.text ?? "0")!
////                        ageList = [childAge1,childAge2,childAge3,childAge4]
//                        ageList = getChildrenAges(childCount: childCount, list: ageList)
//                        return ageList
//                    }
//                    func getChildrenAges(childCount : Int , list : [Int?]) -> [Int] {
//                        var childrenAge : [Int] = []
//                        if childCount != 0 {
//                            for i in 0...childCount - 1  {
//                                childrenAge.append(list[i] ?? 12)
//                            }
//                        }
//                        return childrenAge
//                    }
                }
