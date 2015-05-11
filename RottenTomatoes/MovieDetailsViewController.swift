//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by David Kuchar on 5/10/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    
    var movieDetails: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = NSURL(string: movieDetails.valueForKeyPath("posters.detailed") as! String)!
        movieImageView.setImageWithURL(url)
        
        movieTitleLabel.text = movieDetails["title"] as? String
        movieSynopsisLabel.text = movieDetails["synopsis"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
