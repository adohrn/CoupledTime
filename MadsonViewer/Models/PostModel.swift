//
//  FeedModel.swift
//  MadsonViewer
//
//  Created by Alexander Dohrn on 6/19/18.
//  Copyright © 2018 Alexander Dohrn. All rights reserved.
//

import UIKit

class PostModel {
    var imageData: Data?
    var imageUrl: String?
    var mainText: String?
    var unixDate: Double
    var dateString: String = ""
    
    init(imageUrl: String?, mainText: String?, unixDate: Double) {
        self.imageUrl = imageUrl
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
