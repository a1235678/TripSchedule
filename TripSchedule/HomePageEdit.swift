//
//  HomePageEdit.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/15.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit

struct Books {
    var city: String
    var startDate: Date
    var endDate: Date
    init(city: String, startDate: Date, endDate: Date){
        self.city = city
        self.startDate = startDate
        self.endDate = endDate
    }
}

class HomePageEdit: UIViewController, UITextFieldDelegate {
    
    var books = Books(city: "123", startDate: Date(), endDate: Date())
    
    var cityArray = [String]()
    var startDateArray = [Date]()
    var endDateArray = [Date]()
    
    var myDatePicker: UIDatePicker!
    var myLabel: UILabel!
    
    var myUserDefaults :UserDefaults!
    
    //core data
    var coreDataConnect :CoreDataConnect!
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myRecords :[Record]! = []
    let myContext =
        (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    let myEntityName = "ScheduleBooks"
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var startDatePicker: UITextField!
    @IBOutlet weak var endDatePicker: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // 連接 Core Data
        coreDataConnect = CoreDataConnect(context: self.moc)
        
        // 基本設定
//        self.view.backgroundColor = UIColor.white
//        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    @IBAction func pressDone(_ sender: UIBarButtonItem) {
//        let count = self.navigationController!.viewControllers.count
//        let preController =
//            self.navigationController?.viewControllers[count-2] as! ViewController
//        preController.savingBook = books
        
        myUserDefaults = UserDefaults.standard
        //讀取資料
//        if let info = myUserDefaults.array(forKey: "cityArray") {
//            cityArray = info as! [String]
//        }
//        if let info = myUserDefaults.array(forKey: "startDateArray") {
//            startDateArray = info as! [Date]
//        }
//        if let info = myUserDefaults.array(forKey: "endDateArray") {
//            endDateArray = info as! [Date]
//        }
//
//        print(books)
        
        //儲存資料
        if cityTextField.text != "" {
            
            // 取得目前 seq 的最大值
            var seq = 100
            let selectResult = coreDataConnect.retrieve(myEntityName, predicate:nil, sort: [["bookId":true]], limit: 1)
            if let results = selectResult {
                for result in results {
                    seq = (result.value(forKey: "bookId") as! Int) + 1
                }
            }
            print(seq)
            
            // auto increment
//            var id = 1
//            if let idSeq = myUserDefaults.object(forKey: "idSeq") as? Int {
//                id = idSeq + 1
//            }
            
            // insert
            let insertResult = coreDataConnect.insert(
                myEntityName, attributeInfo: [
                    "bookId" : "\(seq)",
                    "city" : cityTextField.text!,
                    "endDate" : books.endDate,
                    "startDate" : books.startDate
                ])
            
//            if insertResult {
//                print("新增資料成功")
//                
//                // 新增資料至陣列
//                let newRecord = coreDataConnect.retrieve(myEntityName, predicate: "id = \(id)", sort: nil, limit: 1)
//                
//                myRecords.insert((newRecord![0] as! Record), at: 0)
//                
//                // 新增 cell 在第一筆 row
//                myTableView.beginUpdates()
//                myTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
//                myTableView.endUpdates()
//                
//                // 更新 auto increment
//                myUserDefaults.set(id, forKey: "idSeq")
//                myUserDefaults.synchronize()
//                
//                
//            }
        }

        
        cityArray.append(cityTextField.text!)
        startDateArray.append(books.startDate)
        endDateArray.append(books.endDate)
        
        myUserDefaults.setValue(self.cityArray, forKey: "cityArray")
        myUserDefaults.setValue(self.startDateArray, forKey: "startDateArray")
        myUserDefaults.setValue(self.endDateArray, forKey: "endDateArray")
        
        myUserDefaults.synchronize()
        
        print(cityArray)
        
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cityEditingDidEnd(_ sender: Any) {
        books.city = cityTextField.text!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //取得螢幕尺寸
        //let fullScreenSize = UIScreen.main.bounds.size
        
        //建立一個UIDatePicker
        myDatePicker = UIDatePicker()
        
        //設置UIDatePickerMode
        myDatePicker.datePickerMode = .date
        
        //設置預設日期為今天或出發日期
        if (textField.tag == 2 && startDatePicker.text != "") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: startDatePicker.text!)
            myDatePicker.date = date!
        }else{
            myDatePicker.date = Date()
        }
        
        //設置時間顯示格式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        //設置顯示的語言環境
        myDatePicker.locale = Locale(identifier: "zh_TW")
        
        //設置改變日期時會執行的動作
        if textField.tag == 1{
        myDatePicker.addTarget(self, action: #selector(self.datePickerChanged), for: .valueChanged)
        }else if textField.tag == 2{
            myDatePicker.addTarget(self, action: #selector(self.datePickerChanged2), for: .valueChanged)
        }
        
        textField.inputView = myDatePicker
    }
    
    func datePickerChanged(datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDatePicker.text = formatter.string(from: datePicker.date)
        books.startDate = datePicker.date
    }
    func datePickerChanged2(datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        endDatePicker.text = formatter.string(from: datePicker.date)
        books.endDate = datePicker.date
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
