//
//  BooksArray.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/28.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import Foundation

var booksArray: [Dictionary<String, Any>] = []

struct Books {
    var city: String
    var startDate: Date
    var endDate: Date
    var scheduleArray: [Schedule] = []
    var listArray: [Dictionary<String, String>] = []
    var shoppingArray: [Dictionary<String, String>] = []
    
    init(city: String, startDate: Date, endDate: Date){
        self.city = city
        self.startDate = startDate
        self.endDate = endDate
    }
}

struct Schedule{
    var dateTime: Date
    var place: String
    var trafic: String
    var information: String
    var images: [String]
    
//    init(toDoList: String, completed: Bool){
//        self.toDoList = toDoList
//        self.completed = completed
}

struct List{
    var toDoList: String
    var completed: Bool
    init(toDoList: String, completed: Bool){
        self.toDoList = toDoList
        self.completed = completed
    }
}

//儲存紀錄位址的booksArray
func saveFile(){
    let fileManager = FileManager.default
    
    let docUrls = fileManager.urls(for: .documentDirectory, in:
        .userDomainMask)
    let docUrl = docUrls.first
    let url = docUrl?.appendingPathComponent("booksArray.txt")
    print("save")
    print(booksArray)
    let array = booksArray
    (array as NSArray).write(to: url!, atomically: true)
}
