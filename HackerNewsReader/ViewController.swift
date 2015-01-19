//
//  ViewController.swift
//  HackerNewsReader
//
//  Created by Liron Shimrony on 1/18/15.
//  Copyright (c) 2015 Liron Shimrony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableViewStories: UITableView!
    var items:[String] = [String]()
    var appReady = false
    var topTitles: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set top 100 titles
        getTopHundred()
        while(self.items.count != 100){}    //WAIT FOR FETCHING IDS
        
        //GET TOP TITLES
        for x in self.items{
            getSelectionJSON(x)
        }
        
        while(self.topTitles.count != 100){}    //WAITING FOR FETCHING TOP TITLES
        
        
        
        self.tableViewStories.registerClass(CustomReaderCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.topTitles.count-10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        while(self.topTitles.count != 100){}
        let cell: CustomReaderCell = self.tableViewStories.dequeueReusableCellWithIdentifier("cell") as CustomReaderCell
//        cell.textLabel?.text = self.items[indexPath.row]
//        cell.textLabel?.text = self.topTitles[indexPath.row]
        
        let title = self.topTitles[indexPath.row]
//        cell.setCustomCell(title)
        cell.textLabel?.text="AAA"


        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> (){
        println("You selected cell #\(indexPath.row)!")
        
    }
    
    func getTopHundred(){
        let urlAsString = "https://hacker-news.firebaseio.com/v0/topstories.json"
        let url = NSURL(string: urlAsString)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {(data, response, error) in

            var topHundredId = NSString(data: data, encoding: NSUTF8StringEncoding) as String
            topHundredId = topHundredId.substringWithRange(Range<String.Index>(start:advance(topHundredId.startIndex,1), end:advance(topHundredId.endIndex, -1)))
            self.items = topHundredId.componentsSeparatedByString(",")
        }
        
        task.resume()
    }
    
    
    func getSelectionJSON(selectionID: String){
        let url = NSURL(string: "https://hacker-news.firebaseio.com/v0/item/\(selectionID).json")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) {(data, response, error) in
            var articleData = NSString(data: data, encoding:NSUTF8StringEncoding) as String
            var err:NSError?
            var obj: AnyObject? = NSJSONSerialization.JSONObjectWithData(articleData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!, options: nil, error: &err)
            if let jsonObject = obj as? NSDictionary{
                if let title = jsonObject["title"] as? NSString{
                self.topTitles.append(title)
                println("ADDED \(title)")

                }
            }

        }
        task.resume()
    }
    
    
    
    
     
}//END CLASS
