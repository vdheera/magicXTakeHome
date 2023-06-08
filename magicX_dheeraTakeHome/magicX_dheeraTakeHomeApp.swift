//
//  magicX_dheeraTakeHomeApp.swift
//  magicX_dheeraTakeHome
//
//  Created by Dheera Vuppala on 6/5/23.
//

import SwiftUI

/*
 Overall Logic:
 1. Show Static Text!
 2. Load the Events as a Website -- each Event should be it's own EventView; they should be stacked on top of each other (with only one visible at a time on the screen)
 3. Use the DOM to find the Text of first event -- Before This is Done; it should say Loading (something like state here); while state is initial, statusText == Loading; else; use DOM to find first event.
 4. Display that Event Name
 5. Clicking on that Event Name Takes you to Browser Window to Purchase Tickets.
 
 Further Improvements: Add Stylistic Changes to Make it more Understandable
 As you scroll down to new events: the DOM should find the Event Name matching what's on the screen.
 
 */

@main
struct magicX_dheeraTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
