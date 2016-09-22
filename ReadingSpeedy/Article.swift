//
//  Article.swift
//  ReadingSpeedy
//
//  Created by red on 2016. 9. 21..
//  Copyright © 2016년 red. All rights reserved.
//

import Foundation

struct Article {
    var content: String
    var words = [String]()
    
    var afterWords = [String]()
    private var beforeWords = [String]()
    
    init(content: String) {
        if content.contains("\n") {
            let text = content.replacingOccurrences(of: "\n", with: " ")
            self.content = text
        } else {
            self.content = content
        }
        self.words = self.content.components(separatedBy: " ")
        self.afterWords = self.words
    }
    
    mutating func next() -> String? {
        if afterWords.count <= 0 {
            return nil
        }
        let nextWords = afterWords.removeFirst()
        beforeWords.append(nextWords)
        return nextWords
    }
    
    mutating func before() -> String {
        if beforeWords.count <= 0 {
            if let nextWords = afterWords.first {
                return nextWords
            }
            return ""
        }
        if let beforeWords = beforeWords.popLast() {
            afterWords.insert(beforeWords, at: 0)
            return beforeWords
        }
        return ""
    }
    
}
