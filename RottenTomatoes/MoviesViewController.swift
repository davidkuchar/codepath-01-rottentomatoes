//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by David Kuchar on 5/4/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

//TODO
//

import UIKit
import SVProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moviesDictionaries: [NSDictionary]?
    let rottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=f2fk8pundhpxf77fscxvkupy"

    @IBOutlet weak var moviesTableView: MovieTableView!
    @IBOutlet weak var alertView: UIView!
    var refreshControl:UIRefreshControl!

    func loadMoviesData() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: rottenTomatoesURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response, data, error) in
                if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary? {
                    self.moviesDictionaries = dictionary["movies"] as? [NSDictionary]
                    self.moviesTableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    SVProgressHUD.dismiss()
                    
//                    NSLog("Dictionary: \(dictionary)")
                } else {
                    
                    self.refreshControl?.endRefreshing()
                    SVProgressHUD.dismiss()
                    
                    self.alertView.hidden = false
                    
                    println("Network error!!")
                }
            }
        )
    }
    
    func refreshMovies(sender:AnyObject)
    {
        // Code to refresh table view
        self.loadMoviesData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.alertView.hidden = true
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refreshMovies:", forControlEvents: UIControlEvents.ValueChanged)
        self.moviesTableView.addSubview(refreshControl)
        
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
        
        self.loadMoviesData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesDictionaries?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("movieTableCell") as! MovieTableCell

        //    let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)

        let movieDictionary = self.moviesDictionaries![indexPath.row]

        cell.movieTitleLabel?.text = movieDictionary["title"] as? String
        cell.movieSynopsisLabel?.text = movieDictionary["synopsis"] as? String
        
        let url = NSURL(string: movieDictionary.valueForKeyPath("posters.thumbnail") as! String)!
        cell.moviePosterView.setImageWithURL(url)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
//
    @IBAction func toggleViewType(sender: UISegmentedControl) {
        
//        sender.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = self.moviesTableView.indexPathForCell(cell)!
        
        let movieDetails = moviesDictionaries![indexPath.row]
        
        let movieDetailsViewContoller = segue.destinationViewController as! MovieDetailsViewController
        
        movieDetailsViewContoller.movieDetails = movieDetails
    }
}

class MovieTableView: UITableView {
    
}

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
}