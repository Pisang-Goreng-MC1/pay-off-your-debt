//
//  HomeView.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 06/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var isSummaryShow : Bool = true
    @State private var summary : Int = 10000
    
    var body: some View {
        NavigationView{
            VStack {
                //Header Debt
                VStack{
                    //Title and add button
                    HStack{
                        Text("🙌Hi, Buddy!")
                            .fontWeight(.medium)
                        Spacer()
                        NavigationLink( destination: EmptyView()){
                            Image(systemName: "plus")
                        }
                    }
                    .padding(.all)
                    .font(.title2)
                    
                    Text("You Lent")
                        .fontWeight(.medium)
                    HStack(alignment: .center){
                        Text(showSummary(totalAmount: summary, isMoneyShow: isSummaryShow))
                            .fontWeight(.heavy)
                        Image(systemName: isSummaryShow ? "eye.slash" : "eye.fill")
                            .onTapGesture {
                                isSummaryShow.toggle()
                            }
                    }
                    .font(.largeTitle)
                    
                    Text("Check your friend's pocket or unfriend them!")
                        .fontWeight(.ultraLight)
                        .padding(.bottom, 60)
                }
                .foregroundColor(.white)
                // Active Debt
                VStack(alignment: .leading){
                    Text("Active debts")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.vertical, 20)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // TODO: Create debtcard view with a list
                    DebtCard(cardColor: "CardPrimary")
                    DebtCard(cardColor: "CardPrimary")
                    DebtCard(cardColor: "CardSecondary")
                    Spacer()
                }
                .padding(.horizontal, 20)
                .background(.white)
                .cornerRadius(36)
                .padding(.bottom, -50)
                //.cornerRadius(36, corners: [.topLeft, .topRight])
            }
            .background(.blue)
        }
    }
    
    //function show total money
    func showSummary(totalAmount: Int, isMoneyShow: Bool) -> String{
        let stringMoney : String = String(totalAmount)
        //formater to currency indonesia
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if isMoneyShow{
            return ("RP. \(formatter.string(for: totalAmount) ?? "0")")
        }else{
            return ("RP. \(stringToAsterisk(value: stringMoney))")
            
        }
        
    }
    
    //function convert to asterisk
    func stringToAsterisk(value : String) -> String{
        return String(repeating: "*", count: value.count)
    }
}

//Debt Card Components
struct DebtCard: View {
    var cardColor : String
    var body: some View {
        NavigationLink(destination: EmptyView()){
            HStack(spacing: 60.0){
                Text("Alexander MonMon")
                VStack(){
                    Text("I Owe RP. 25.000")
                    Text("31 days ago")
                }
                
            }
            .padding(.horizontal, 10.0)
            .frame(width: 360, height: 100, alignment: .center)
            .background(Color(cardColor))
            .foregroundColor(.white)
            .cornerRadius(19)
            .contextMenu(){
                Button (){
                    // Add this item to a list of favorites.
                } label: {
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
