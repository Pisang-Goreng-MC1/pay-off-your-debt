//
//  ListActiveDebts.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 11/04/23.
//

import SwiftUI
import CoreData

struct ListActiveDebts: View {
    @FetchRequest(
        entity: Wallet.entity(),
        sortDescriptors: [],
        animation: .default)
    private var wallets: FetchedResults<Wallet>
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Active debts")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.all, 20)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                List {
                    ForEach(wallets, id: \.id) {wallet in
                        let temp = wallet.debts?.reduce(0) { (accumulator, debt) in
                            if let type = (debt as! Debt).type {
                                if type == "Owe" {
                                    return (accumulator ?? 0) - Int(((debt as! Debt).amount))
                                } else {
                                    return (accumulator ?? 0) + Int(((debt as! Debt).amount))
                                }
                            } else {
                                return accumulator
                            }
                        } ?? 0
                        
                        DebtCard(personName: wallet.person?.name ?? "Unknown", totalAmount: Int32(temp))
                    }
                }.listStyle(.plain)
            }
        }
        //        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(24)
        .padding(.bottom, -50)
    }
    
    
}

struct ListActiveDebts_Previews: PreviewProvider {
    static var previews: some View {
        ListActiveDebts()
    }
}
