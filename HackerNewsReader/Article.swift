//
//  Article.swift
//  HackerNewsReader
//
//  Created by Liron Shimrony on 1/18/15.
//  Copyright (c) 2015 Liron Shimrony. All rights reserved.
//

import Foundation

class Article{
    
    var by: String
    var id: String
    var score: Int
    var title: String
    var type: String
    var url: String
    
    
    init(by: String, id: String, score: Int, title: String ,type: String, url: String){
        self.by = by
        self.id = id
        self.score = score
        self.title = title
        self.type = type
        self.url = url    
    }
}
