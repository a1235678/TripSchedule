//
//  Record.swift
//  TripSchedule
//
//  Created by Apple Hsiao on 2016/11/22.
//  Copyright © 2016年 zeroplus. All rights reserved.
//

import Foundation
import CoreData


class Record: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
}

extension Record {
    
    @NSManaged var id: NSNumber?
    @NSManaged var city: String?
    @NSManaged var startDate: Date?
    @NSManaged var endDate: Date?
    
}
