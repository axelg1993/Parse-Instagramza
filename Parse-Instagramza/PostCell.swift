//
//  PostCell.swift
//  Parse-Instagramza
//
//  Created by Axel Guzman on 3/19/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postedImageView: PFImageView!
    
    var post: PFObject! {
        didSet{
            usernameLabel.text = post["author"].username
            captionLabel.text = post["caption"] as? String
            postedImageView.file = post["media"] as? PFFile
            postedImageView.loadInBackground()
        }
    }
    
      /*  for object in objects! {
        if let originalImage = object["image"] as? PFFile {
        dispatch_group_enter(downloadGroup)
    
        originalImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
        images?.insert(addimage, atIndex: 0)
        dispatch_group_leave(downloadGroup)
    
    }
    })}
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue()) {
    // This will be called when all your downloads are complete
    print("GO GO GO Grand Central Dispatch!!")
    completionHandler(images: images, success: true, error: nil)
    }*/
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
        // Configure the view for the selected state
    }

}
