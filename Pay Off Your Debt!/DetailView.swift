//
//  DetailView.swift
//  Pay Off Your Debt!
//
//  Created by Roli Bernanda on 06/04/23.
//
struct Loan {
    let amount: Int
    let type: String;
    let note: String;
    let createdAt: String;
}

import SwiftUI

struct DetailView: View {
    @State private var loans: [Loan] = [
        Loan(amount: 10000, type: "Lent", note: "Kopi 1 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 20000, type: "Borrow", note: "Kopi 2 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 30000, type: "Borrow", note: "Kopi 3 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 40000, type: "Lent", note: "Kopi 4 Cangkir", createdAt: "21/01/01"),
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                VStack {
                    Text ("Your Recent Debtsssss")
                    HStack {
                        Text ("- Rp.1.000.000")
                            .foregroundColor(.red)
                            .font(.system(size: 25))
                            .bold()
                        
                        Image (systemName: "eye.slash.fill")
                    }
                    Spacer()
                        .frame(minHeight:35,maxHeight:35)
                }
                .padding(.all, 20.0)
                .frame(maxWidth: .infinity)
                .background (Color("YellowBgt"))
                
                
                VStack {
                    List {
                        ForEach(loans, id: \.amount) {
                            loan in ListItem(amount: loan.amount, type: loan.type, note: loan.note, createdAt: loan.createdAt)
                        }
                        
                    }.listStyle(.plain)
                }
                
                
            }
            .navigationBarTitle("Monica", displayMode: .inline)
            
        }
    }
}

struct ListItem: View {
    @State var amount: Int
    @State var type: String
    @State var note: String
    @State var createdAt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text ("I Owe Rp \(amount)")
            HStack(spacing: 5) {
                Image (systemName: "eye.slash.fill").resizable().scaledToFit().frame(width: 14)
                Text(type).font(.system(size: 14)).opacity(0.5)
            }
            Text(note).font(.system(size: 14)).opacity(0.5)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}




