//
//  ShoppingViewController.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/29.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import UIKit
//import CoreImage

class ShoppingViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var shopTableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    //var name: String = ""
    
    var listArray = booksArray[bookNumber]["shoppingList"] as? [[String: Any]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //點選新增
    @IBAction func addButton(_ sender: UIButton) {
        print("insertPressed")
        
        //儲存資料
        if let addLabel = textView.text, let addImage = image.image{
            
            //取得路徑
            let fileManager = FileManager.default
            let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            //檔名
            let interval = Date.timeIntervalSinceReferenceDate
            let name = "\(interval).jpg"
            
            let url = docUrl?.appendingPathComponent(name)
            let data = UIImageJPEGRepresentation(addImage, 0.9)
            try! data?.write(to: url!)
            
            if listArray == nil{
                booksArray[bookNumber]["shoppingList"] = []
                listArray = booksArray[bookNumber]["shoppingList"] as! [[String : Any]]?
            }
            
            
            
            listArray!.append(["text": addLabel, "completion": false, "image": name])
        
            textView.text = ""
            image.image = nil
            
            booksArray[bookNumber]["shoppingList"] = listArray
            saveFile()
            
            shopTableView.reloadData()
        }
    }
    
    //資料刪除
    func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCellEditingStyle, forRowAt
        indexPath: IndexPath) {
        
        self.listArray!.remove(at: indexPath.row)
        tableView.deleteRows(at:[indexPath], with: UITableViewRowAnimation.fade)
        
        booksArray[bookNumber]["shoppingList"] = listArray
        saveFile()
    }
    
    //設定圖片
    @IBAction func changeImg(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    //取得照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.image.image = image
        
        
        self.dismiss(animated:true, completion: nil)
        
        
        //重整Table
        //shopTableView.reloadData()
    }

    
    //是否完成
    @IBAction func completeButton(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let index = shopTableView.indexPath(for: cell)?.row
        
        if listArray![index!]["completion"] as! Bool == true{
            sender.setImage(#imageLiteral(resourceName: "uncheck"), for: UIControlState.normal )
            listArray![index!]["completion"] = false
        }else{
            sender.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal )
            listArray![index!]["completion"] = true
        }
        
        booksArray[bookNumber]["shoppingList"] = listArray
        saveFile()
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        if let listArray = listArray{
            if indexPath.row == listArray.count + 1{
            return false
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int
        
        if let listArray = listArray{
            rows = listArray.count
        }else{
            rows = 0
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "shoplist", for: indexPath)
            
            let img = cell.contentView.viewWithTag(1) as! UIImageView
            let textView = cell.contentView.viewWithTag(2) as! UITextView
            let completeButton = cell.contentView.viewWithTag(3) as! UIButton
            
            textView.text = listArray![indexPath.row]["text"] as? String!
            //let fileName = listArray![indexPath.row]["image"]
            
            if let fileName = listArray![indexPath.row]["image"] as? String{
                //讀取圖片
                let fileManager = FileManager.default
                let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                let docUrl = docUrls.first
                let url = docUrl?.appendingPathComponent(fileName)
                img.image = UIImage(contentsOfFile: (url!.path))
                
            }else{
                img.image = nil
            }
            
            if listArray![indexPath.row]["completion"] as! Bool == false{
                completeButton.setImage(#imageLiteral(resourceName: "uncheck"), for: UIControlState.normal )
            }else{
                completeButton.setImage(#imageLiteral(resourceName: "checked"), for: UIControlState.normal )
            }
            return cell
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
