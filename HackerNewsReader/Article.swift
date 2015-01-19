//
//  Article.swift
//  HackerNewsReader
//
//  Created by Liron Shimrony on 1/18/15.
//  Copyright (c) 2015 Liron Shimrony. All rights reserved.
//

import Foundation

class Article{
    
    var by: String?
    var id: String?
    var kids: String?
    var score: String?
    var time: String?
    var title: String?
    var type: String?
    var url: String?
    
    
    init(by: String?, id: String?, kids: String?, score: String?, time: String? ,title: String? ,type: String?, url: String?){
        self.by = by
        self.id = id
        self.kids = kids
        self.score = score
        self.time = time
        self.title = title
        self.type = type
        self.url = url    
    }
}
