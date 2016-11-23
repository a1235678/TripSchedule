//
//  ViewController.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/15.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var booksArray: [Books] = []
    
    var myUserDefaults: UserDefaults!
    
    var coreDataConnect :CoreDataConnect!
    var myRecords :[Record]! = []
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var booksTableView: UITableView!
    
    let myContext =
        (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    let myEntityName = "ScheduleBooks"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 連接 Core Data
        coreDataConnect = CoreDataConnect(context: self.moc)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Books",
                for: indexPath)
        let name = booksArray[indexPath.row].city
        let start = booksArray[indexPath.row].startDate
        let end = booksArray[indexPath.row].endDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        cell.textLabel?.text = formatter.string(from: start) + " ~ " + formatter.string(from: end) + "   " + name + "之旅"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OpenBook", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 取得資料
        let results = coreDataConnect.retrieve(myEntityName,
                                                    predicate: nil,
                                                    sort: [["bookId":false]],
                                                    limit:nil)

        var index = 0
        for result in results! {
            if let city = result.value(forKey: "city")! as? String,
                let start = result.value(forKey: "startDate")! as? Date,
                let end = result.value(forKey: "endDate")! as? Date{
                let books: Books = Books(city: city, startDate: start, endDate: end)
                booksArray.append(books)
            }
            index += 1
        }
        
        //booksTableView.reloadData()
        
        print("viewDidLoad()")
        print(booksArray)
        
    }


}

