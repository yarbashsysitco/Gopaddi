//
//  HotelPopUpViewController.swift
//  Birdview Travels
//
//  Created by jizan k on 16/03/23.
//

import UIKit
import iOSDropDown

class HotelsPopUpViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet weak var r4ChildCountTF: DropDown!
    @IBOutlet weak var r4AdultCountTF: DropDown!
    @IBOutlet weak var r4Set1View: UIView!
    @IBOutlet weak var r4Set2View: UIView!
    @IBOutlet weak var r4Set1ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var r4Set2ViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var r4InfoView: MyView!
    @IBOutlet weak var r4InfoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var r4Child1Age: DropDown!
    @IBOutlet weak var r4Child2Age: DropDown!
    @IBOutlet weak var r4Child3Age: DropDown!
    @IBOutlet weak var r4Child4Age: DropDown!
    @IBOutlet weak var r4Child1View: UIView!
    @IBOutlet weak var r4Child2View: UIView!
    @IBOutlet weak var r4Child3View: UIView!
    @IBOutlet weak var r4Child4View: UIView!
    
    @IBOutlet weak var r3ChildCountTF: DropDown!
    @IBOutlet weak var r3AdultCountTF: DropDown!
    @IBOutlet weak var r3Set1View: UIView!
    @IBOutlet weak var r3Set2View: UIView!
    @IBOutlet weak var r3Set1ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var r3Set2ViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var r3InfoView: MyView!
    @IBOutlet weak var r3InfoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var r3Child1Age: DropDown!
    @IBOutlet weak var r3Child2Age: DropDown!
    @IBOutlet weak var r3Child3Age: DropDown!
    @IBOutlet weak var r3Child4Age: DropDown!
    @IBOutlet weak var r3Child1View: UIView!
    @IBOutlet weak var r3Child2View: UIView!
    @IBOutlet weak var r3Child3View: UIView!
    @IBOutlet weak var r3Child4View: UIView!
    
    @IBOutlet weak var r2ChildCountTF: DropDown!
    @IBOutlet weak var r2AdultCountTF: DropDown!
    @IBOutlet weak var r2Set1View: UIView!
    @IBOutlet weak var r2Set2View: UIView!
    @IBOutlet weak var r2Set1ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var r2Set2ViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var r2InfoView: MyView!
    @IBOutlet weak var r2InfoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var r2Child1Age: DropDown!
    @IBOutlet weak var r2Child2Age: DropDown!
    @IBOutlet weak var r2Child3Age: DropDown!
    @IBOutlet weak var r2Child4Age: DropDown!
    @IBOutlet weak var r2Child1View: UIView!
    @IBOutlet weak var r2Child2View: UIView!
    @IBOutlet weak var r2Child3View: UIView!
    @IBOutlet weak var r2Child4View: UIView!
    
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
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var numberOfRooms: DropDown!
    let childCount = ["0","1","2","3","4"]
    let adultCount = ["1","2","3","4"]
    let childAge = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var occupancyFinalList : [Occupancy] = []
    var occupancyFinalList1 : [Any] = []
    var delegate : PInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.backgroundColor = .clear
        dropDownSetUp()
        initSetUp()
        room1SetUp()
        room2SetUp()
        room3SetUp()
        room4SetUp()
    }
    func initSetUp(){
        self.r1InfoViewHeight.constant = 238
        self.r2InfoViewHeight.constant = 0
        self.r3InfoViewHeight.constant = 0
        self.r4InfoViewHeight.constant = 0
        self.r2InfoView.isHidden = true
        self.r3InfoView.isHidden = true
        self.r4InfoView.isHidden = true
        self.r1Set1View.isHidden = true
        self.r1Set2View.isHidden = true
        self.r2Set1View.isHidden = true
        self.r2Set2View.isHidden = true
        self.r3Set1View.isHidden = true
        self.r3Set2View.isHidden = true
        self.r4Set1View.isHidden = true
        self.r4Set2View.isHidden = true
        self.scrollViewHeight.constant = 300
        self.setScrollContentHeight()
        numberOfRooms.didSelect{(selectedText , index ,id) in
            self.numberOfRooms.text = selectedText
            self.initHeight()
            switch selectedText {
            case "1" :
                self.r2InfoView.isHidden = true
                self.r3InfoView.isHidden = true
                self.r4InfoView.isHidden = true
                self.setUpRoom1View()
                self.setScrollContentHeight()
            case "2" :
                self.r2InfoView.isHidden = false
                self.r3InfoView.isHidden = true
                self.r4InfoView.isHidden = true
                self.setUpRoom1View()
                self.setUpRoom2View()
                self.setScrollContentHeight()
            case "3" :
                self.r2InfoView.isHidden = false
                self.r3InfoView.isHidden = false
                self.r4InfoView.isHidden = true
                self.setUpRoom1View()
                self.setUpRoom2View()
                self.setUpRoom3View()
                self.setScrollContentHeight()
            case "4" :
                self.r2InfoView.isHidden = false
                self.r3InfoView.isHidden = false
                self.r4InfoView.isHidden = false
                self.setUpRoom1View()
                self.setUpRoom2View()
                self.setUpRoom3View()
                self.setUpRoom4View()
                self.setScrollContentHeight()
            default:
                print("Invalid")
            }
        }
    }
    func initHeight(){
        self.r1InfoViewHeight.constant = 0
        self.r2InfoViewHeight.constant = 0
        self.r3InfoViewHeight.constant = 0
        self.r4InfoViewHeight.constant = 0
    }
    func setScrollContentHeight(){
        self.contentViewHeight.constant = self.r1InfoViewHeight.constant + self.r2InfoViewHeight.constant + self.r3InfoViewHeight.constant + self.r4InfoViewHeight.constant + 60
        if self.contentViewHeight.constant < 750 {
            self.scrollViewHeight.constant = self.contentViewHeight.constant
        }else {
            self.scrollViewHeight.constant = 750
        }
    }
    private func dropDownSetUp(){
        numberOfRooms.optionArray = adultCount
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
            self.r1AdultCountTF.text = selectedText
        }
        r1ChildCountTF.didSelect{(selectedText , index ,id) in
            self.r1ChildCountTF.text = selectedText
            self.setUpRoom1View()
        }
    }
    func setUpRoom1View(){
        switch self.r1ChildCountTF.text {
        case "0" :
                self.room1ChildViewInit()
                self.r1Set1View.isHidden = true
                self.r1Set2View.isHidden = true
                self.r1InfoViewHeight.constant = 238
//                self.setScrollContentHeight()
        case "1" :
                self.room1ChildViewInit()
                self.r1Set1View.isHidden = false
                self.r1Set2View.isHidden = true
                self.r1Child1View.isHidden = false
                self.r1Child2View.isHidden = true
                self.r1InfoViewHeight.constant = 330
//                self.setScrollContentHeight()
        case "2" :
                self.room1ChildViewInit()
                self.r1Set1View.isHidden = false
                self.r1Set2View.isHidden = true
                self.r1Child1View.isHidden = false
                self.r1Child2View.isHidden = false
                self.r1InfoViewHeight.constant = 330
//                self.setScrollContentHeight()
        case "3" :
                self.room1ChildViewInit()
                self.r1Set1View.isHidden = false
                self.r1Set2View.isHidden = false
                self.r1Child1View.isHidden = false
                self.r1Child2View.isHidden = false
                self.r1Child3View.isHidden = false
                self.r1Child4View.isHidden = true
                self.r1InfoViewHeight.constant = 388
//                self.setScrollContentHeight()
        case "4" :
                self.room1ChildViewInit()
                self.r1Set1View.isHidden = false
                self.r1Set2View.isHidden = false
                self.r1Child1View.isHidden = false
                self.r1Child2View.isHidden = false
                self.r1Child3View.isHidden = false
                self.r1Child4View.isHidden = false
                self.r1InfoViewHeight.constant = 388
//                self.setScrollContentHeight()
        default : print("Invalid")
        }
        self.setScrollContentHeight()
            
    }
    private func room2SetUp(){
        r2AdultCountTF.didSelect{(selectedText , index ,id) in
            self.r2AdultCountTF.text = selectedText
        }
        r2ChildCountTF.didSelect{(selectedText , index ,id) in
            self.r2ChildCountTF.text = selectedText
            self.setUpRoom2View()
        }
    }
    func setUpRoom2View(){
        switch self.r2ChildCountTF.text {
        case "0" :
            self.room2ChildViewInit()
            self.r2Set1View.isHidden = true
            self.r2Set2View.isHidden = true
            self.r2InfoViewHeight.constant = 120
//            self.setScrollContentHeight()
        case "1" :
            self.room2ChildViewInit()
            self.r2Set1View.isHidden = false
            self.r2Set2View.isHidden = true
            self.r2Child1View.isHidden = false
            self.r2Child2View.isHidden = true
            self.r2InfoViewHeight.constant = 205
//            self.setScrollContentHeight()
        case "2" :
            self.room2ChildViewInit()
            self.r2Set1View.isHidden = false
            self.r2Set2View.isHidden = true
            self.r2Child1View.isHidden = false
            self.r2Child2View.isHidden = false
            self.r2InfoViewHeight.constant = 205
//            self.setScrollContentHeight()
        case "3" :
            self.room2ChildViewInit()
            self.r2Set1View.isHidden = false
            self.r2Set2View.isHidden = false
            self.r2Child1View.isHidden = false
            self.r2Child2View.isHidden = false
            self.r2Child3View.isHidden = false
            self.r2Child4View.isHidden = true
            self.r2InfoViewHeight.constant = 260
//            self.setScrollContentHeight()
        case "4" :
            self.room2ChildViewInit()
            self.r2Set1View.isHidden = false
            self.r2Set2View.isHidden = false
            self.r2Child1View.isHidden = false
            self.r2Child2View.isHidden = false
            self.r2Child3View.isHidden = false
            self.r2Child4View.isHidden = false
            self.r2InfoViewHeight.constant = 260
//            self.setScrollContentHeight()
        default : print("Invalid")
        }
        self.setScrollContentHeight()
    }
    private func room3SetUp(){
        r3AdultCountTF.didSelect{(selectedText , index ,id) in
            self.r3AdultCountTF.text = selectedText
        }
        r3ChildCountTF.didSelect{(selectedText , index ,id) in
            self.r3ChildCountTF.text = selectedText
            self.setUpRoom3View()
        }
    }
    func setUpRoom3View(){
        switch self.r3ChildCountTF.text {
        case "0" :
            self.room3ChildViewInit()
            self.r3Set1View.isHidden = true
            self.r3Set2View.isHidden = true
            self.r3InfoViewHeight.constant = 120
//            self.setScrollContentHeight()
        case "1" :
            self.room3ChildViewInit()
            self.r3Set1View.isHidden = false
            self.r3Set2View.isHidden = true
            self.r3Child1View.isHidden = false
            self.r3Child2View.isHidden = true
            self.r3InfoViewHeight.constant = 202
//            self.setScrollContentHeight()
        case "2" :
            self.room3ChildViewInit()
            self.r3Set1View.isHidden = false
            self.r3Set2View.isHidden = true
            self.r3Child1View.isHidden = false
            self.r3Child2View.isHidden = false
            self.r3InfoViewHeight.constant = 202
//            self.setScrollContentHeight()
        case "3" :
            self.room3ChildViewInit()
            self.r3Set1View.isHidden = false
            self.r3Set2View.isHidden = false
            self.r3Child1View.isHidden = false
            self.r3Child2View.isHidden = false
            self.r3Child3View.isHidden = false
            self.r3Child4View.isHidden = true
            self.r3InfoViewHeight.constant = 257
//            self.setScrollContentHeight()
        case "4" :
            self.room3ChildViewInit()
            self.r3Set1View.isHidden = false
            self.r3Set2View.isHidden = false
            self.r3Child1View.isHidden = false
            self.r3Child2View.isHidden = false
            self.r3Child3View.isHidden = false
            self.r3Child4View.isHidden = false
            self.r3InfoViewHeight.constant = 257
//            self.setScrollContentHeight()
        default : print("Invalid")
        }
        self.setScrollContentHeight()
    }
    private func room4SetUp(){
        r4AdultCountTF.didSelect{(selectedText , index ,id) in
            self.r4AdultCountTF.text = selectedText
        }
        r4ChildCountTF.didSelect{(selectedText , index ,id) in
            self.r4ChildCountTF.text = selectedText
            self.setUpRoom4View()
        }
    }
    func setUpRoom4View(){
        switch self.r4ChildCountTF.text {
        case "0" :
            self.room4ChildViewInit()
            self.r4Set1View.isHidden = true
            self.r4Set2View.isHidden = true
            self.r4InfoViewHeight.constant = 120
//            self.setScrollContentHeight()
        case "1" :
            self.room4ChildViewInit()
            self.r4Set1View.isHidden = false
            self.r4Set2View.isHidden = true
            self.r4Child1View.isHidden = false
            self.r4Child2View.isHidden = true
            self.r4InfoViewHeight.constant = 213
//            self.setScrollContentHeight()
        case "2" :
            self.room4ChildViewInit()
            self.r4Set1View.isHidden = false
            self.r4Set2View.isHidden = true
            self.r4Child1View.isHidden = false
            self.r4Child2View.isHidden = false
            self.r4InfoViewHeight.constant = 213
//            self.setScrollContentHeight()
        case "3" :
            self.room4ChildViewInit()
            self.r4Set1View.isHidden = false
            self.r4Set2View.isHidden = false
            self.r4Child1View.isHidden = false
            self.r4Child2View.isHidden = false
            self.r4Child3View.isHidden = false
            self.r4Child4View.isHidden = true
            self.r4InfoViewHeight.constant = 270
//            self.setScrollContentHeight()
        case "4" :
            self.room4ChildViewInit()
            self.r4Set1View.isHidden = false
            self.r4Set2View.isHidden = false
            self.r4Child1View.isHidden = false
            self.r4Child2View.isHidden = false
            self.r4Child3View.isHidden = false
            self.r4Child4View.isHidden = false
            self.r4InfoViewHeight.constant = 270
//            self.setScrollContentHeight()
        default : print("Invalid")
        }
        self.setScrollContentHeight()
    }
   
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true)
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
        r2Child1View.isHidden = true
        r2Child2View.isHidden = true
        r2Child3View.isHidden = true
        r2Child4View.isHidden = true
    }
    private func room3ChildViewInit(){
        r3Child1View.isHidden = true
        r3Child2View.isHidden = true
        r3Child3View.isHidden = true
        r3Child4View.isHidden = true
    }
    private func room4ChildViewInit(){
        r4Child1View.isHidden = true
        r4Child2View.isHidden = true
        r4Child3View.isHidden = true
        r4Child4View.isHidden = true
    }
    @IBAction func didTapApplyBtn(_ sender: Any) {
        occupancyFinalList.removeAll()
        var finalAdultC : Int?
        var finalChildC : Int?
        switch self.numberOfRooms.text{
        case "1": let occupancy1 = room1FinalSet()
            finalAdultC = occupancy1.adult
            finalChildC = occupancy1.child
            setUPList(occupancy: occupancy1)
        case "2" : let occupancy1 = room1FinalSet()
            setUPList(occupancy: occupancy1)
            let occupancy2 =  room2FinalSet()
            setUPList(occupancy: occupancy2)
            finalAdultC = occupancy1.adult + occupancy2.adult
            finalChildC = occupancy1.child + occupancy2.child
        case "3" : let occupancy1 = room1FinalSet()
            setUPList(occupancy: occupancy1)
            let occupancy2 = room2FinalSet()
            setUPList(occupancy: occupancy2)
            let occupancy3 = room3FinalSet()
            setUPList(occupancy: occupancy3)
            finalAdultC = occupancy1.adult + occupancy2.adult + occupancy3.adult
            finalChildC = occupancy1.child + occupancy2.child + occupancy3.child
            occupancyFinalList = [occupancy1 ,occupancy2, occupancy3]
        case "4" : let occupancy1 = room1FinalSet()
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
        let roomCount = Int(numberOfRooms.text ?? "1")!
        delegate?.clientDetails(occupancy: occupancyFinalList1 , roomC : roomCount, childC : finalChildC! , adultNo : finalAdultC!)
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
        let childAge1 = Int(r1Child1Age.text ?? "12")!
        let childAge2 = Int(r1Child2Age.text ?? "12")!
        let childAge3 = Int(r1Child3Age.text ?? "12")!
        let childAge4 = Int(r1Child4Age.text ?? "12")!
        var ageList : [Int] = [0]
        let childCount = Int(r1ChildCountTF.text ?? "0")!
        ageList = [childAge1,childAge2,childAge3,childAge4]
        ageList = getChildrenAges(childCount: childCount, list: ageList)
        let occupancyList = Occupancy(room_no: 1, adult: Int(r1AdultCountTF.text ?? "1")!, child: Int(r1ChildCountTF.text ?? "0")!, child_age: ageList)
        return occupancyList
    }
    func room2FinalSet() -> Occupancy{
        let childAge1 = Int(r2Child1Age.text ?? "12")!
        let childAge2 = Int(r2Child2Age.text ?? "12")!
        let childAge3 = Int(r2Child3Age.text ?? "12")!
        let childAge4 = Int(r2Child4Age.text ?? "12")!
        var occupancyList : Occupancy?
        var ageList : [Int] = [childAge1,childAge2,childAge3,childAge4]
        let childCount = Int(r2ChildCountTF.text ?? "0")!
        ageList = getChildrenAges(childCount: childCount, list: ageList)
        occupancyList = Occupancy(room_no: 2, adult: Int(r2AdultCountTF.text ?? "1")!, child: Int(r2ChildCountTF.text ?? "0")!, child_age: ageList)
        return occupancyList!
    }
    func room3FinalSet() -> Occupancy{
        let childAge1 = Int(r3Child1Age.text ?? "12")!
        let childAge2 = Int(r3Child2Age.text ?? "12")!
        let childAge3 = Int(r3Child3Age.text ?? "12")!
        let childAge4 = Int(r3Child4Age.text ?? "12")!
        var occupancyList : Occupancy?
        var ageList : [Int] = [childAge1,childAge2,childAge3,childAge4]
        let childCount = Int(r3ChildCountTF.text ?? "0")!
        ageList = getChildrenAges(childCount: childCount, list: ageList)
        occupancyList = Occupancy(room_no: 3, adult: Int(r3AdultCountTF.text ?? "1")!, child: Int(r3ChildCountTF.text ?? "0")!, child_age: ageList)
        return occupancyList!
    }
    func room4FinalSet() -> Occupancy{
        let childAge1 = Int(r4Child1Age.text ?? "12")!
        let childAge2 = Int(r4Child2Age.text ?? "12")!
        let childAge3 = Int(r4Child3Age.text ?? "12")!
        let childAge4 = Int(r4Child4Age.text ?? "12")!
        var occupancyList : Occupancy?
        var ageList : [Int] = [childAge1,childAge2,childAge3,childAge4]
        let childCount = Int(r4ChildCountTF.text ?? "0")!
        ageList = getChildrenAges(childCount: childCount, list: ageList)
        occupancyList = Occupancy(room_no: 4, adult: Int(r4AdultCountTF.text ?? "1")!, child: Int(r4ChildCountTF.text ?? "0")!, child_age: ageList)
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
}
