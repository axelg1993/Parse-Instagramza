//
//  ViewController.swift
//  Parse-Instagramza
//
//  Created by Axel Guzman on 3/14/16.
//  Copyright © 2016 Axel Guzman. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print("nil posts")
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        
        print("Logged out")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func onCaptureButton(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            print("Camera not available")
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
    
    

    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            let submitViewController = storyboard?.instantiateViewControllerWithIdentifier("SubmitViewController") as! SubmitViewController
            
            submitViewController.selectedImage = editedImage
            
            picker.presentViewController(submitViewController, animated: true, completion: nil)
    }
    
  
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        cell.post = posts![indexPath.row]
        
        return cell
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
    }
    
    
    
    


}

