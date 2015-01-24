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
    var topHundredDictionary: [String: Article]=[:]
    var topHundredArticles = [Article]()
    var appReady = false

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getTopHundredV2()

        
    
//            self.getTopHundredV2()
        
//            })
        

        while(self.topHundredArticles.count < 90){}
        self.topHundredArticles.sort{$0.score > $1.score}   //Sort articles by score
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.topHundredArticles.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
        let cell: CustomReaderCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomReaderCell
        
        let article = self.topHundredArticles[indexPath.row]
        println(article.title)
        cell.setCustomCell(article.title, id: article.id, score: String(article.score), author: article.by, url: article.url)

        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> (){
        println("You selected cell #\(topHundredArticles[indexPath.row].title)! #\(topHundredArticles.count)")
        
        
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
    
    
//    func getSelectionJSON(selectionID: String){
//        let url = NSURL(string: "https://hacker-news.firebaseio.com/v0/item/\(selectionID).json")
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!) {(data, response, error) in
//            var articleData = NSString(data: data, encoding:NSUTF8StringEncoding) as String
//            var err:NSError?
//            var obj: AnyObject? = NSJSONSerialization.JSONObjectWithData(articleData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!, options: nil, error: &err)
//            if let jsonObject = obj as? NSDictionary{
//                
//                
//                
//                //Create Article Object
//                if let title = jsonObject["title"] as? NSString{
//                    if let author = jsonObject["by"] as? NSString{
//                        if let score = jsonObject["score"] as? Int{
//                            if let type = jsonObject["type"] as? NSString{
//                                if let url = jsonObject["url"] as? NSString{
//                                    let article: Article = Article(by: author, id: selectionID, score: score, title: title, type: type, url: url)
//                                    self.topArticles.append(article)
////                                    println("ADDED \(article.title)")
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
//    
    
    
    
    
    func getTopHundredV2(){
        let url: NSURL! = NSURL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")
        let queue = NSOperationQueue()
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:
            {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if (error != nil){
                    println(error.localizedDescription)
                }
                else{

                    self.createTopHundredDictionary(data)
                }
            })
    }
    
    func createTopHundredDictionary(data: NSData){
        
        //Convert string of IDs to array of strings
        var idArrayAsString = NSString(data: data, encoding:NSUTF8StringEncoding) as String

        idArrayAsString = idArrayAsString.substringWithRange(Range<String.Index>(start:advance(idArrayAsString.startIndex,1), end:advance(idArrayAsString.endIndex, -1)))
        
        let topHundredId = idArrayAsString.componentsSeparatedByString(",")
        
        for id in topHundredId{
            getArticleFromJSON(id)
            
        }
        
        
    }
    
    
    func getArticleFromJSON(id: String){
        let url = NSURL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")
        let request = NSURLRequest(URL: url!)
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
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
                                        let article = Article(by: author, id: id, score: score, title: title, type: type, url: url)
                                        self.topHundredDictionary[id] = article
                                        self.topHundredArticles.append(article)
                                    }
                                }
                            }
                        }
                    }
                }
            })
    }
    


    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewArticle"{

            var selectedCell = sender as CustomReaderCell

            var urlPath = selectedCell.urlLabel.text
            let destinationVC = segue.destinationViewController as ArticleViewControlelr
            destinationVC.url = NSURL(string: urlPath!)
            

        }
    }
    
}//END CLASS
