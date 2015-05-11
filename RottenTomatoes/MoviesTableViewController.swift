//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by David Kuchar on 5/4/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

//TODO
//
//4. User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at http://cocoapods.wantedly.com?q=hud.
//5. User sees error message when there's a networking error. You may not use UIAlertView or a 3rd party library to display the error. See this screenshot for what the error message should look like: network error screenshot.
//6. User can pull to refresh the movie list. Guide: Using UIRefreshControl

import UIKit

class MoviesTableViewController: UITableViewController {

    var moviesDictionaries: [NSDictionary]?

    func loadMoviesData() {
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=f2fk8pundhpxf77fscxvkupy"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response, data, error) in
                if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary? {
                    self.moviesDictionaries = dictionary["movies"] as? [NSDictionary]
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    
//                    NSLog("Dictionary: \(dictionary)")
                } else {
                    
                    
                }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMoviesData()
    }

    @IBAction func refreshMovies(sender: AnyObject) {
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesDictionaries?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("movieTableCell") as! MovieTableCell

        //    let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)

        let movieDictionary = self.moviesDictionaries![indexPath.row]

        cell.movieTitleLabel?.text = movieDictionary["title"] as? String
        cell.movieSynopsisLabel?.text = movieDictionary["synopsis"] as? String
        
        let url = NSURL(string: movieDictionary.valueForKeyPath("posters.thumbnail") as! String)!
        cell.moviePosterView.setImageWithURL(url)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        
        let movieDetails = moviesDictionaries![indexPath.row]
        
        let movieDetailsViewContoller = segue.destinationViewController as! MovieDetailsViewController
        
        movieDetailsViewContoller.movieDetails = movieDetails
        
        println("I'm about to segue")
    }
}

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
}