//
//  FeedTableViewCell.swift
//  MadsonViewer
//
//  Created by Alexander Dohrn on 6/14/18.
//  Copyright © 2018 Alexander Dohrn. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var leftBorderView: UIView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
