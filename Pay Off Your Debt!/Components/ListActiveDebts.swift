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
        sortDescriptors: [],
        animation: .default)
    private var wallets: FetchedResults<Wallet>
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Active debts")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack{
                List {
                    ForEach(wallets, id: \.id) {
                        wallet in DebtCard(personName: wallet.person?.name ?? "Unknown", type: "owe", totalAmount: wallet.totalAmount)
                    }
                }.listStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
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
