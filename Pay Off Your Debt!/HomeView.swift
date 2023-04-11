//
//  HomeView.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 06/04/23.
//

import SwiftUI

struct DebtType: Identifiable {
    let id = UUID()
    var name: String
}

struct HomeView: View {
    let persistenceController = PersistenceController.shared
    // Initial Data
    @State var People: [Person] = []
    @State var debtTypes: [DebtType] = [
        DebtType(name: "Lent"),
        DebtType(name: "Owe")]
    
    
    // Status
    @State private var showingSheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var showingContacts: Bool = false
    
    
    @State private var isSummaryShow : Bool = true
    @State private var summary : Int = 10000
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack{
            VStack {
                //Header Debt
                VStack{
                    //Title and add button
                    HStack{
                        Text("🙌Hi, Buddy!")
                            .fontWeight(.medium)
                        Spacer()
                        Button{
                            showingSheet.toggle()
                        }label: {
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
                ListActiveDebts()
            }
            .background(.blue)
            .sheet(isPresented: $showingSheet) {
                AddDebtSheet(showingContacts: $showingContacts, showingAlert: $showingAlert, showingSheet: $showingSheet)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
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
    
    private func AddRepay() {
        // TODO:
    }
}

//
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
