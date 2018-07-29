//
//  SmashTweetTableViewController.swift
//  Smashtag
//
//  Created by Jan Polzer on 7/28/18.
//  Copyright © 2018 Michel Deiman. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController {
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func insetTweets(_ newTweets: [Twitter.Tweet]) {
        super.insetTweets(newTweets)
        updateDatabase(with: newTweets)
    }

    private func updateDatabase(with  tweets: [Twitter.Tweet]) {
        container?.performBackgroundTask { context in
            for twitterInfo in tweets {
                // add tweet
            }
            
        }
    }
}
