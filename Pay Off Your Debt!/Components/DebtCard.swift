//
//  DebtCard.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 11/04/23.
//

import SwiftUI

struct DebtCard: View {
    @State var personName: String
    @State var type: String // TODO: hitung banyakan hutang atau ngutangin
    @State var totalAmount: Int32
    //    @State var createdAt: String // TODO:
    
    var body: some View {
        NavigationLink(destination: DetailView(personName: personName)){
            HStack(spacing: 60.0){
                Text("\(personName)")
                    .bold()
                Spacer()
                VStack(){
                    Text("I \(type) \(moneyFormater(amount: totalAmount))")
                        .foregroundColor((type == "owe" ? .red : .green))// TODO: Format currency
                    Text("31 days ago")
                        .italic()// TODO
                }
                
            }
            .padding(.horizontal, 20)
            .frame(width: 360, height: 80, alignment: .center)
            .foregroundColor(.black)
        }
    }
}

struct DebtCard_Previews: PreviewProvider {
    static var previews: some View {
        DebtCard(personName: "Alexander MonMon", type: "lent", totalAmount: 10000)
    }
}
