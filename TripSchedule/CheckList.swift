//
//  CheckList.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/16.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit

class CheckList: UIViewController, UITableViewDataSource {
    @IBOutlet weak var insertText: UITextField!
    var listArray: [List] = []
    
    @IBAction func insertButton(_ sender: Any) {
        
        //儲存資料
        if insertText.text != "" {
            
            
            // insert
//            let insertResult = coreDataConnect.insert(
//                myEntityName, attributeInfo: [
//                    "toDoList" : insertText.text!,
//                    "completed" : false
//                ])
      
        }
    }
    
    func getData(){
        // 取得資料
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "checklist", for: indexPath)
        //cell.accessoryType = .checkmark
        
        //listArray[indexPath.row].toDoList
        //listArray[indexPath.row].completed
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
