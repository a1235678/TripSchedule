//
//  NewViewController.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/29.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    var listArray = booksArray[bookNumber]["schedule"] as? [[String: Any]]
    @IBOutlet weak var subView: UIView!
    
    @IBAction func goBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        let timeLabel = subView.viewWithTag(1) as! UITextField
        let placeLabel = subView.viewWithTag(2) as! UITextField
        let trafficLabel = subView.viewWithTag(3) as! UITextField
        let costLabel = subView.viewWithTag(4) as! UITextField
        let infoLabel = subView.viewWithTag(5) as! UITextField
        
        if listArray == nil{
            booksArray[bookNumber]["schedule"] = []
            listArray = booksArray[bookNumber]["schedule"] as! [[String : Any]]?
        }

        listArray!.append(["time": timeLabel.text!, "place": placeLabel.text!, "traffic": trafficLabel.text!, "cost": costLabel.text!, "info": infoLabel.text!])
        booksArray[bookNumber]["schedule"] = listArray
        saveFile()
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
