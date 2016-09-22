//
//  ViewController.swift
//  ReadingSpeedy
//
//  Created by red on 2016. 9. 19..
//  Copyright © 2016년 red. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var tempTextView: NSTextView!
    
    @IBOutlet weak var displayLabel: NSTextField!
    
    var article: Article!
    
    var timeInterval: TimeInterval {
        get {
            return 0.3
        }
    }

    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewSetup()
        articleSetup()

    }
    
    @IBAction func readStart(_ sender: AnyObject) {
        timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: { (timer) in
            if let article = self.article {
                self.showWords(article.afterWords)
            }
        })
    }
    
    func showWords(_ words: [String]) {
        print(words.first)
        if words.count <= 0 {
            return
        }

        guard let firstString = self.article.next() else {
            self.displayLabel.stringValue = "End"
            return
        }
        self.displayLabel.stringValue = firstString
        
    }
    
    var mainQueue = DispatchQueue.main
    
    func displayWord(_ word: String) {
        displayLabel.stringValue = word
    }
    
    @IBAction func stop(_ sender: AnyObject) {
        timer.invalidate()
    }
    
    
    @IBAction func showNextWord(_ sender: AnyObject) {
        timerStop()
        if let nextWord = article.next() {
            displayWord(nextWord)
        }
        
    }
    
    @IBAction func showBeforeWord(_ sender: AnyObject) {
        timerStop()
        let beforeWord = article.before()
        displayWord(beforeWord)
    }
    
}

extension ViewController {
    
    func timerStop() {
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    func textViewSetup() {
        displayLabel.stringValue = ""
    }

    
    func articleSetup() {
        /* 추후 pasteBoard 에서 가져오는걸로 변경. */
//        let pasteBoard = NSPasteboard.general()
        if let content = tempTextView.string {//pasteBoard.string(forType: NSPasteboardTypeString) {
            article = Article(content: content)
        }
    }
}
