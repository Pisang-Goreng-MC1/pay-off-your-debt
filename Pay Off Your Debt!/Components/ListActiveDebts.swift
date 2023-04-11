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
                .fontWeight(.heavy)
                .padding(.vertical, 20)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // TODO: Create debtcard view with a list
            ScrollView{
                VStack(spacing: 20){
                    ForEach(wallets, id: \.id) {
                        wallet in DebtCard(personName: wallet.person?.name ?? "Unknown", type: "owe", totalAmount: wallet.totalAmount, cardColor: "CardPrimary")
                    }
                }
            }
            .padding(.bottom)
            .frame(height: 500)
            Spacer()
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
