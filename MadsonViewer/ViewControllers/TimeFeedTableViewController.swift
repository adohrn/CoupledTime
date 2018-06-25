//
//  TimeFeedTableViewController.swift
//  MadsonViewer
//
//  Created by Alexander Dohrn on 6/20/18.
//  Copyright © 2018 Alexander Dohrn. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TimeFeedTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var posts: [PostModel] = []
    var colorCycle: [UIColor] = [UIColor.init(red: 244/255, green: 26/255, blue: 79/255, alpha: 1),
                                 UIColor.init(red: 255/255, green: 101/255, blue: 35/255, alpha: 1),
                                 UIColor.init(red: 249/255, green: 194/255, blue: 46/255, alpha: 1),
                                 UIColor.init(red: 83/255, green: 179/255, blue: 203/255, alpha: 1),
                                 UIColor.init(red: 114/255, green: 109/255, blue: 168/255, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100.0;
        
        ref = Database.database().reference()
        
        let now = Date()
        let monthDay = "\(Calendar.current.component(.month, from: now))-\(Calendar.current.component(.day, from: now))"
        
        let _ = ref.child("Feed").queryOrdered(byChild: "monthDay").queryEqual(toValue: monthDay).observe(DataEventType.value, with: { (snapshot) in
            self.posts = []
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let value = snap.value as? NSDictionary
                
                // Main text and date are required
                if let unixDate = value!["unixDate"] as? Double {
                    let mainText = value?["text"] as? String
                    let imageUrl = value?["imageUrl"] as? String
                    
                    self.posts.insert(PostModel.init(imageUrl: imageUrl, mainText: mainText, unixDate: unixDate), at: 0)
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        cell.dateLabel?.text = posts[indexPath.row].dateString
        
        if posts[indexPath.row].mainText != nil {
            cell.mainText?.text = posts[indexPath.row].mainText
            cell.mainText.sizeToFit()
        } else {
            cell.mainText.isHidden = true
        }
        
        if let imageUrl = posts[indexPath.row].imageUrl {
            let url = URL(string: imageUrl)
            cell.mainImage.kf.setImage(with: url)
        } else {
            cell.imageViewHeight.constant = 0
        }
        
        cell.leftBorderView.backgroundColor = colorCycle[indexPath.row % 5]
        
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
