//
//  ArticleViewControlelr.swift
//  HackerNewsReader
//
//  Created by Liron Shimrony on 1/24/15.
//  Copyright (c) 2015 Liron Shimrony. All rights reserved.
//

import UIKit

class ArticleViewControlelr: UIViewController {

    
    var url:NSURL!
    
    @IBOutlet weak var articleWebView: UIWebView!
    
    
    @IBAction func backToolbarButton(sender: AnyObject) {
        self.articleWebView.goBack()
    }
    
    @IBAction func forwardToolbarButton(sender: AnyObject) {
        self.articleWebView.goForward()
    }
    
    
    @IBAction func closeWebView(sender: AnyObject) {
        dismissViewControllerAnimated(true,nil)
    }
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        var urlRequest = NSURLRequest(URL: url)
        self.articleWebView.loadRequest(urlRequest)


       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        
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
