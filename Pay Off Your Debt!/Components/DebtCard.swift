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
    
    var cardColor : String
    
    var body: some View {
        NavigationLink(destination: DetailView(personName: personName)){
            HStack(spacing: 60.0){
                Text("\(personName)")
                VStack(){
                    Text("I \(type) RP. \(totalAmount)") // TODO: Format currency
                    Text("31 days ago") // TODO
                }
                
            }
            .padding(.horizontal, 10.0)
            .frame(width: 360, height: 100, alignment: .center)
            .background(Color(cardColor))
            .foregroundColor(.white)
            .cornerRadius(19)
            .contextMenu(){
                NavigationLink(destination: EmptyView()) {
                    Label("Repay", systemImage: "checkmark.circle.fill")
                }
                Button (role: .destructive){
                    // Open Maps and center it on this item.
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

//struct DebtCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DebtCard()
//    }
//}
