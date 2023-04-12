//
//  Utils.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 11/04/23.
//

import Foundation
import SwiftUI

func moneyFormater(amount: Int32) -> String{
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    
    return ("RP. \(formatter.string(for: amount) ?? "0")")
}

func changeColorByTypeDebt(amount: Int) -> Color{
    return amount < 0 ? Color("SecondaryColor") : Color("PrimaryColor")
}

func getMessagesByDebtType(label: String) -> [String] {
    let messagesByDebtType = [
        ("Oh, congratulations. You've reached a new level of incompetence.", "owe"),
        ("Great job, genius. You've managed to make things worse.", "owe"),
        ("Wow, you really have a talent for making bad decisions, don't you?", "owe"),
        ("Fantastic, you've succeeded in making everyone's day worse.", "owe"),
        ("Bravo, you've outdone yourself in creating a disaster.", "owe"),
        ("check your friend pocket or unfriend them", "lent"),
        ("Don't worry about your friend owing you money. Just consider it a gift to their financial stability and move on.", "lent"),
        ("Maybe you should start a collection agency, or just unfriend them and save yourself HAHAHA.", "lent"),
        ("Oh, your friend owes you money? maybe you can do a charity for", "lent"),
        ("check their pockets and see if they magically found the cash.", "lent"),
        ("go click plus button", "neutral"),
        ("ok", "neutral"),
        ("Why did you install this app if you never use it? useless.", "neutral"),
        (">.<", "neutral"),
        ("Good morning aksjdbtywk", "neutral")
    ]
    
    let filteredMessages = messagesByDebtType.filter { $0.1 == label }
//    guard let message = filteredMessages.first?.0 else { return "" }
    return filteredMessages.map { $0.0 }
}

func getDebtTypeByAmount(totalAmount: Int) -> String {
    if totalAmount < 0 {
        return "owe"
    } else if totalAmount > 0 {
        return "lent"
    } else {
        return "neutral"
    }
}





