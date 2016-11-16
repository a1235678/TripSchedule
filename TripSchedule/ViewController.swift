//
//  ViewController.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/15.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var booksArray = [Books]()
    
    var cityArray = [String]()
    var startDateArray = [Date]()
    var endDateArray = [Date]()
    
    var myUserDefaults: UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Books",
                for: indexPath)
        let name = cityArray[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OpenBook", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let tag = sender as! Int
//        let controller = segue.destination as! movie
//        controller.movieDetail = movieArray[tag]
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier == "DetailView") {
//            var vc = segue.destinationViewController as DetailViewController
//        }
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        print("viewDidLoad()")
        print(cityArray)
        
    }


}

