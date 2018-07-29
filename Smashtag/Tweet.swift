//
//  Tweet.swift
//  Smashtag
//
//  Created by Jan Polzer on 7/28/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class Tweet: NSManagedObject {

    class func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, in context: NSManagedObjectContext) -> Tweet {
        
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.identifier)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count > 1, "Tweet.findOrCreate -- database incosistency")
                
                return matches[0]
            }
        } catch {
            print(error)
        }
        
        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        tweet.text = twitterInfo.text
        tweet.created = twitterInfo.created
        tweet.tweeter = try? TwitterUser.findOrCreateTwitterUser(matching: twitterInfo.user, in: context)
        
        return tweet
    }
}
