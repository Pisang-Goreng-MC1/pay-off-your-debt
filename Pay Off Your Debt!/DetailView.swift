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
    
    
    @State private var bgColorRed = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var favoriteColor="anjay"
    var colors = ["anjay", "anjay2"]
    
    var body: some View {
        NavigationView{
            ZStack (alignment: .top){
                Color.blue.ignoresSafeArea()
                VStack{
                    VStack{
                        Text("You Owe")
                            .font(.system(size: 48))
                            .fontWeight(.heavy)
                        Text("RP10.000")
                        Text("Check your friend's pocket or unfriend them!")
                        HStack{
                            VStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 150,height: 50)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .foregroundColor(.red)
                                    }
                                Text("Add")
                            }
                            VStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 150,height: 50)
                                    .overlay {
                                        Image(systemName: "banknote")
                                            .foregroundColor(.red)
                                    }
                                Text("Repay")
                            }
                            
                        }
                        
                        
                    }
                    
                    .frame(maxWidth: .infinity)
                    
                    
                    VStack(alignment: .leading){
                        Picker("What is", selection:$favoriteColor){
                            ForEach(colors, id: \.self) {
                                Text($0)
                            }
                            
                        }
                        .padding(30)
                        .pickerStyle(.segmented)
                        .frame(width: 250)
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .background(.white)
                    .cornerRadius(24)
                    .padding(.bottom, -50)
                    .padding(.bottom)
                    .frame(height: 500)
                }
                
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                            Image(systemName: "chevron.backward")
                    }
                    ToolbarItem(placement: .principal){
                        Text("HI")
                    }
                }
            .background(Color.blue)
            }
            
        }
        
        
        //                VStack {
        //                    List {
        //                        ForEach(loans, id: \.amount) {
        //                            loan in ListItem(amount: loan.amount, type: loan.type, note: loan.note, createdAt: loan.createdAt)
        //                        }
        //
        //                    }.listStyle(.plain)
        //                }
        
        
        
    }
    
}




//struct ListItem: View {
//    @State var amount: Int
//    @State var type: String
//    @State var note: String
//    @State var createdAt: String
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text ("I Owe Rp \(amount)")
//            HStack(spacing: 5) {
//                Image (systemName: "eye.slash.fill").resizable().scaledToFit().frame(width: 14)
//                Text(type).font(.system(size: 14)).opacity(0.5)
//            }
//            Text(note).font(.system(size: 14)).opacity(0.5)
//        }
//    }
//}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}




