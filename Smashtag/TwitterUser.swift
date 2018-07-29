//
//  TwitterUser.swift
//  Smashtag
//
//  Created by Jan Polzer on 7/28/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit
import CoreData
import Twitter


class TwitterUser: NSManagedObject {
    static func findOrCreateTwitterUser(matching twitterInfo: Twitter.User, in context: NSManagedObjectContext) throws -> TwitterUser {
        
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "handle = %@", twitterInfo.screenName)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count > 1, "Tweet.findOrCreate -- database incosistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let twitterUser = TwitterUser(context: context)
        twitterUser.handle = twitterInfo.screenName
        twitterUser.name = twitterInfo.name
        
        return twitterUser
    }
}
