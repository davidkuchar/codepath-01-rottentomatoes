//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by David Kuchar on 5/4/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

//TODO
//
//1. User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
//2. User can view movie details by tapping on a cell.
//3. Hint: The Rotten Tomatoes API stopped returning high resolution images. To get around that, use the URL to the thumbnail poster, but replace 'tmb' with 'ori'.
//4. User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at http://cocoapods.wantedly.com?q=hud.
//5. User sees error message when there's a networking error. You may not use UIAlertView or a 3rd party library to display the error. See this screenshot for what the error message should look like: network error screenshot.
//6. User can pull to refresh the movie list. Guide: Using UIRefreshControl

import UIKit

class ViewController: UITableViewController {

    var moviesDictionaries: [NSDictionary]?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=f2fk8pundhpxf77fscxvkupy"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response, data, error)
                in
                if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary? {
                    self.moviesDictionaries = dictionary["movies"] as? [NSDictionary]
                    self.tableView.reloadData()
                    NSLog("Dictionary: \(dictionary)")
                } else {
            
            
            }
        })
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
    return moviesDictionaries?.count ?? 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("movieTableCell") as! MovieTableCell
    
//    let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)

    let movieDictionary = self.moviesDictionaries![indexPath.row]
//
    cell.movieTitleLabel?.text = movieDictionary["title"] as! String?
    
    return cell
  }
    
}

class MovieTableCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
}