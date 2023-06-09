//
//  AddDebtDetailSheet.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 12/04/23.
//

import SwiftUI
import Combine

struct AddDebtDetailSheet: View {
    var personName: String
    @State private var amount: String = ""
    @State private var personalNote: String = ""
    @State private var repaymentDate: Date = Date()
    @State private var debtType: String = "Owe"
    @Binding var showingSheet: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    var wallets: FetchedResults<Wallet>
    
    func addDebt() {
        withAnimation {
            // TODO: kalo target person blm ada create baru, kalo dah ada langsung tambahin
            // TODO:  Kalo belum ada walletnya create baru. Kalo dah ada langsung tambahin debt di walletnya
            
            let newDebt = Debt(context: viewContext)
            newDebt.id = UUID()
            newDebt.amount = Int32(amount) ?? 0 // TODO: Integrate
            newDebt.personalNote = personalNote  // TODO: Integrate
            newDebt.type = debtType // TODO: Integrate
            newDebt.repaymentDate = Date()
            newDebt.createdAt = Date()
            
            if let existingWallet = wallets.first(where: { $0.person?.name ?? "" == personName }) {

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
    
    func isButtonDisabled() -> Bool{
        return amount.isEmpty || amount == "0"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        Text(personName)
                        TextField("IDR0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .onReceive(Just(amount)) { newAmount in
                                //                            let regex = try NSRegularExpression (pattern: "^[0-9]*$")
                                let filtered = newAmount.filter {
                                    //                                $0.contains(Regex("^[0-9]*$"))
                                    "0123456789".contains($0)
                                }
                                if filtered != newAmount {
                                    self.amount = filtered
                                    
                                }
                            }
                        
                        //TODO : Repayment Date
//                        HStack {
//                            Text("Repayment Date")
//                            Spacer()
//                            DatePicker(
//                                "",
//                                selection: $repaymentDate,
//                                in: Date()...,
//                                displayedComponents: [.date]
//                            )
//                        }
                        TextField("Personal Note", text: $personalNote)
                    }
                    Section {
                        HStack {
                            Text("Type")
                            Spacer()
                            Picker("", selection: $debtType) {
                                Text("Owe").tag("Owe")
                                Text("Lent").tag("Lent")
                            }
                        }
                    }
                    Section {
                        Button {
                            self.showingSheet.toggle()
                            addDebt() // TODO:
                        }
                    label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(isButtonDisabled())
                    .listRowBackground(isButtonDisabled() ? Color.gray : Color.accentColor   )
                    .foregroundColor(Color.white)
                    }
                    
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .navigationBarTitle("New Debt",displayMode: .inline)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .presentationDetents([.fraction(0.6)])
        .presentationDragIndicator(.visible)
    }
}

//struct AddDebtSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDebtSheet()
//    }
//}
