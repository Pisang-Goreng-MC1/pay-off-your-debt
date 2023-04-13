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
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Debt.entity(), sortDescriptors: []) var debts: FetchedResults<Debt>
    
    var totalSummary: Int32 {
        debts.reduce(0) { result, item in
            let amount = item.amount * (item.type == "Owe" ? -1 : 1)
            return result + amount
        }
    }
    
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
                    
                    Text("You \(getDebtTypeByAmount(totalAmount: totalSummary))")
                        .fontWeight(.medium)
                    HStack(alignment: .center){
                        Text(showSummary(totalAmount: Int32(totalSummary), isMoneyShow: isSummaryShow))
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
                    Text(getMessagesByDebtType(label: getDebtTypeByAmount(totalAmount: totalSummary)).first ?? "")
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                        .padding(.horizontal, 20.0)
                }
                .foregroundColor(.white)
                // Active Debt
                ListActiveDebts()
            }
            .background(changeColorByTypeDebt(amount: Int32(totalSummary)))
            .sheet(isPresented: $showingSheet) {
                AddDebtSheet(showingContacts: $showingContacts, showingAlert: $showingAlert, showingSheet: $showingSheet)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
        //        .tint(Color.white)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //function show total money
    func showSummary(totalAmount: Int32, isMoneyShow: Bool) -> String{
        let stringMoney : String = "Rp\(String(abs(totalAmount)))"
        //formater to currency indonesia
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if isMoneyShow{
            return ("Rp\(formatter.string(for: abs(totalAmount)) ?? "0")")
        }else{
            return (stringToAsterisk(value: stringMoney))
            
        }
        
    }
    
    //function convert to asterisk
    func stringToAsterisk(value : String) -> String{
        return String(repeating: "*", count: value.count + 2)
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
