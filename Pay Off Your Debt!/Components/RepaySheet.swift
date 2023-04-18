//
//  RepaySheet.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 13/04/23.
//

import SwiftUI
import Combine

struct RepaySheet: View {
    @State private var amount: String = ""
    @State private var personalNote: String = ""
    @Binding var showingSheet: Bool
    var person: String
    
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    var wallets: FetchedResults<Wallet>
    
    func isButtonDisabled() -> Bool{
        return amount.isEmpty
    }
    
    func addRepay()  {
        withAnimation {
            // TODO: kalo target person blm ada create baru, kalo dah ada langsung tambahin
            
            
            // TODO:  Kalo belum ada walletnya create baru. Kalo dah ada langsung tambahin debt di walletnya
            
            let newDebt = Debt(context: viewContext)
            newDebt.id = UUID()
            
            newDebt.amount = Int32(amount) ?? 0
            newDebt.personalNote = personalNote
            newDebt.type = "Repay"
            newDebt.repaymentDate = Date()
            newDebt.createdAt = Date()
            
            if let existingWallet = wallets.first(where: { $0.person?.name ?? "" == person }) {

                if var debts = existingWallet.mutableSetValue(forKey: "debts") as? Set<Debt> {
                    newDebt.person = existingWallet.person
                    debts.insert(newDebt)
                    existingWallet.debts = debts as NSSet
                }
                
            }
            
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this functionw in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("IDR0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .onReceive(Just(amount)) { newAmount in
                                let filtered = newAmount.filter {
                                    "0123456789".contains($0)
                                }
                                if filtered != newAmount {
                                    self.amount = filtered
                                }
                            
                            }
                        TextField("Personal Note", text: $personalNote)
                        
                    }
                    Section {
                        Button {
                            print("masuk gan")
                            self.showingSheet.toggle()
                            self.addRepay()
                        } label: {
                            Text("Repay")
                                .frame(maxWidth: .infinity)
                        }
                        // () ? true : false
                        .listRowBackground(isButtonDisabled() ? Color.gray : Color.accentColor)
                        .foregroundColor(Color.white)
                        .disabled(isButtonDisabled())
                    }
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Repay",displayMode: .inline)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .presentationDetents([.fraction(0.4)])
        .presentationDragIndicator(.visible)
    }
}

//struct AddDebtSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDebtSheet()
//    }
//}
