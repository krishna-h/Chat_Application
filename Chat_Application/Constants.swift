//
//  Constants.swift
//  Chat_Application
//
//  Created by Mac on 20/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import Foundation
struct Constants {
    static let appName = "⚡️Rama_Chat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LogInToChat"
    static let resetSegue = "goToReSetPassword"
    
    
    
    
    struct BrandColors{
        static let purple = "BrandPurple"
         static let lightPurple = "BrandLightPurple"
         static let blue = "BrandBlue"
         static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let CollectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        
    }
}
