//
//  ViewController.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/15.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var booksTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadFile()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Books",
                for: indexPath)
        let name = booksArray[indexPath.row]["city"] as! String
        let start = booksArray[indexPath.row]["startDate"]
        let end = booksArray[indexPath.row]["endDate"]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        //formatter.string(from: start as! Date) + " ~ " + formatter.string(from: end as! Date) + "   " +
        cell.textLabel?.text = name + "之旅"
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
        
        booksTableView.reloadData()
        
        print("viewDidLoad()")
        print(booksArray)
        
    }
    
    //讀取紀錄位址的bookArray
    func loadFile(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in:
            .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("booksArray.txt")
        
        if let array = NSArray(contentsOf: url!){
            booksArray = array as! [Dictionary<String, Any>]
        }
        print(docUrl)
        booksTableView.reloadData()
    }


}

