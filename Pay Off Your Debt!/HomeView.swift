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
                        Text("Hi, Buddy!")
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
                    
                    Text("You \(getDebtTypeByAmount(totalAmount: summary))")
                        .fontWeight(.medium)
                    HStack(alignment: .center){
                        Text(showSummary(totalAmount: summary, isMoneyShow: isSummaryShow))
                            .fontWeight(.bold)
                        Image(systemName: isSummaryShow ? "eye.slash" : "eye.fill")
                            .font(.system(size: 20))
                            .onTapGesture {
                                isSummaryShow.toggle()
                            }
                    }
                    .font(.largeTitle)
                    Spacer()
                        .frame(height: 5)
                    Text(getMessagesByDebtType(label: getDebtTypeByAmount(totalAmount: summary)).first ?? "")
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 50)
                        .padding(.horizontal, 20.0)
                }
                .foregroundColor(.white)
                // Active Debt
                ListActiveDebts()
            }
            .background(changeColorByTypeDebt(amount: summary))
            .sheet(isPresented: $showingSheet) {
                AddDebtSheet(showingContacts: $showingContacts, showingAlert: $showingAlert, showingSheet: $showingSheet)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
    
    //function show total money
    func showSummary(totalAmount: Int, isMoneyShow: Bool) -> String{
        let stringMoney : String = "RP\(String(abs(totalAmount)))"
        //formater to currency indonesia
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if isMoneyShow{
            return ("RP\(formatter.string(for: abs(totalAmount)) ?? "0")")
        }else{
            return (stringToAsterisk(value: stringMoney))
            
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
