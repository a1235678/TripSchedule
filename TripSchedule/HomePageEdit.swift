//
//  HomePageEdit.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/15.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit

struct Books {
    var city: String!
    var startDate: Date
    var endDate: Date
    init(){
        city = ""
        startDate = Date()
        endDate = Date()
    }
}

class HomePageEdit: UIViewController, UITextFieldDelegate {
    
    var books = Books()
    
    var cityArray = [String]()
    var startDateArray = [Date]()
    var endDateArray = [Date]()
    
    var myDatePicker: UIDatePicker!
    var myLabel: UILabel!
    
    var myUserDefaults :UserDefaults!
    
    //core data
    let myContext =
        (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    let myEntityName = "Books"
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var startDatePicker: UITextField!
    @IBOutlet weak var endDatePicker: UITextField!
    

    @IBAction func pressDone(_ sender: UIBarButtonItem) {
//        let count = self.navigationController!.viewControllers.count
//        let preController =
//            self.navigationController?.viewControllers[count-2] as! ViewController
//        preController.savingBook = books
        
        myUserDefaults = UserDefaults.standard
        //讀取資料
        if let info = myUserDefaults.array(forKey: "cityArray") {
            cityArray = info as! [String]
        }
        if let info = myUserDefaults.array(forKey: "startDateArray") {
            startDateArray = info as! [Date]
        }
        if let info = myUserDefaults.array(forKey: "endDateArray") {
            endDateArray = info as! [Date]
        }

        print(books)
        
        //儲存資料
        
        // insert
        let insetData = NSEntityDescription.insertNewObject(
            forEntityName: myEntityName, into: myContext)
        
        insetData.setValue(1, forKey: "id")
        insetData.setValue("Jesse", forKey: "name")
        insetData.setValue(176.2, forKey: "height")
        
        do {
            try myContext.save()
        } catch {
            fatalError("\(error)")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    @IBAction func cityEditingDidEnd(_ sender: Any) {
        books.city = cityTextField.text
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
