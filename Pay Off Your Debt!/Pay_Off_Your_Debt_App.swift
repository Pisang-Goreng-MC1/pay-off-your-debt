//
//  Pay_Off_Your_Debt_App.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 03/04/23.
//

import SwiftUI

@main
struct Pay_Off_Your_Debt_App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            DetailView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


