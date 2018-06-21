//
//  FeedModel.swift
//  MadsonViewer
//
//  Created by Alexander Dohrn on 6/19/18.
//  Copyright © 2018 Alexander Dohrn. All rights reserved.
//

import UIKit

class PostModel {
    var imageData: String?
    var mainText: String?
    var unixDate: Double
    var dateString: String = ""
    
    init(imageData: String?, mainText: String?, unixDate: Double) {
        self.imageData = imageData
        self.mainText = mainText
        self.unixDate = unixDate
        self.dateString = convertDate(unixTime: unixDate)
    }
    
    func convertDate(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd, yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}
