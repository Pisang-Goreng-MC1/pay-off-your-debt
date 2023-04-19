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
    @State private var messageInSummary = ""
    
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
                    Text(messageInSummary)
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
                    .environment(\.colorScheme, .light)
            }
            .onChange(of: totalSummary) { _ in
                messageInSummary = getMessagesByDebtType(label: getDebtTypeByAmount(totalAmount: totalSummary))
            }
            .onAppear{
                messageInSummary = getMessagesByDebtType(label: getDebtTypeByAmount(totalAmount: totalSummary))
            }
        }
        
        .overlay(showingSheet ? Color.black.opacity(0.5) : Color.black.opacity(0))
        //        .tint(Color.white)

        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    //function show total money
    
}

//
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
