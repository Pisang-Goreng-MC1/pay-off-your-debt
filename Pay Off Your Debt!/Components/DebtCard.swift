//
//  DebtCard.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 11/04/23.
//

import SwiftUI

struct DebtCard: View {
    @State var personName: String
//    @State var type: String // TODO: hitung banyakan hutang atau ngutangin
    var totalAmount: Int32
    //    @State var createdAt: String // TODO:
    
    var body: some View {
        NavigationLink(destination: DetailView(personName: personName, totalAmount: totalAmount)){
            HStack(){
                Grid {
                    GridRow {
                        Text("\(personName)")
                            .bold()
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("\(totalAmount < 0 ? (totalAmount * -1) : totalAmount)")
                                .foregroundColor((totalAmount < 0 ? .red : .green))
//                            Text("I \(moneyFormater(amount: totalAmount))")
//
                                // TODO: Format currency
                            Text("2 days ago")
                                .italic()// TODO
                        }
                    }
                }
                
                
            }
            .foregroundColor(.black)
        }
    }
}

struct DebtCard_Previews: PreviewProvider {
    static var previews: some View {
        DebtCard(personName: "Alexander MonMon", totalAmount: 10000)
    }
}
