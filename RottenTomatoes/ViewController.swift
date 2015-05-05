//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by David Kuchar on 5/4/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDataSource {

//  var moviesDictionaries: Dictionary
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0//moviesDictionaries?.count
  }
//  
//  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    
//    return 0
//    
//  }
}