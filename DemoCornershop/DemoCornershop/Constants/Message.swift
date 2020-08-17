//
//  Message.swift
//  DemoCornershop
//
//  Created by Everis on 8/17/20.
//  Copyright © 2020 Everis. All rights reserved.
//

import Foundation


struct Message {
    
    struct Welcome {
        static let title = "Welcome to\nCounters"
        static let titleOrange = "Counters"
    }
    
    struct Home {
        static let title = "Counters"
        
        static func footerTitle(numberOfItems: Int, nomberOfCounts: Int) -> String{
            "\(numberOfItems) items · Counted \(nomberOfCounts) times"
        }
        
        struct BarButtonText {
            static let done = "Done"
            static let edit = "Edit"
            static let deselectAll = "Deselect All"
            static let selectAll = "Select All"
        }
    }
    
    struct Create {
        static let title = "Create a counter"
        static let disclaimer = "Give it a name. Creative block? See examples."
        static let disclaimerUnderline = "examples"
        
        struct BarButtonText {
            static let cancel = "Cancel"
            static let save = "Save"
        }
    }
    
    struct Alert {
        struct Title {
            static let appName = "Counter App"
            static let errorToCreateCounter = "Couldn't create the counter"
            static let errorToDeleteCounter = "Couldn’t delete  the counter"
            static let errorToLoadCounter = "Couldn't load your counters"
            static func errorToUpdateCounter(counterName: String, count: Int) -> String{
                "Couldn’t update  the \"\(counterName)\" counter to \(count)"
            }
        }
        
        struct ErrorMessage {
            static let notInternetConnection = "The Internet connection appears to be offline."
            static func createCounterSuccess(name: String) -> String{
                "Your \"\(name)\" counter has been created"
            }
        }
        
        struct ButtonName{
            static let dismiss = "Dismiss"
            static let retry = "Retry"
            static let cancel = "Cancel"
        }
    }
}
