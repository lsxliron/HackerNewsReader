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
    var topTitles: [String] = [String]()
    var topArticles: [Article] = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set top 100 titles
        getTopHundred()
        while(self.items.count != 100){}    //WAIT FOR FETCHING IDS
        
        //GET TOP TITLES
        for id in self.items{
            getSelectionJSON(id)
        }
        while(self.topArticles.count != 99){}    //WAITING FOR FETCHING TOP TITLES
        self.topArticles.sort{$0.score > $1.score}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.topArticles.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
        while(self.topArticles.count != 99){}
        let cell: CustomReaderCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomReaderCell
        let article = self.topArticles[indexPath.row]
        cell.setCustomCell(article.title, score: String(article.score), author: article.by, url: article.url)



        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> (){
        println("You selected cell #\(topArticles[indexPath.row].title)!")
        
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
                
                
                
                //Create Article Object
                if let title = jsonObject["title"] as? NSString{
                    if let author = jsonObject["by"] as? NSString{
                        if let score = jsonObject["score"] as? Int{
                            if let type = jsonObject["type"] as? NSString{
                                if let url = jsonObject["url"] as? NSString{
                                    let article: Article = Article(by: author, id: selectionID, score: score, title: title, type: type, url: url)
                                    self.topArticles.append(article)
//                                    println("ADDED \(article.title)")
                                }
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
    
     
}//END CLASS
