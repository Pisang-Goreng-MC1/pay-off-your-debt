//
//  AddDebtSheet.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 11/04/23.
//

import SwiftUI
import Combine

struct AddDebtSheet: View {
    @State private var person: String = ""
    @State private var amount: String = ""
    @State private var personalNote: String = ""
    @State private var repaymentDate: Date = Date()
    @State private var debtType: String = "Owe"
    @Binding var showingContacts: Bool
    @Binding var showingAlert: Bool
    @Binding var showingSheet: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func addDebt() {
        withAnimation {
            // TODO: kalo target person blm ada create baru, kalo dah ada langsung tambahin
            // TODO:  Kalo belum ada walletnya create baru. Kalo dah ada langsung tambahin debt di walletnya
            
            let newWallet = Wallet(context: viewContext)
            let newDebt = Debt(context: viewContext)
            let newPerson = Person(context: viewContext)
            
            newWallet.id = UUID()
            newWallet.totalAmount = 10000 // TODO: integrate
            
            newPerson.id = UUID() //
            newPerson.name = "ME" // TODO:
            
            newDebt.id = UUID()
            newDebt.amount = 20000 // TODO: Integrate
            newDebt.personalNote = "note" // TODO: Integrate
            newDebt.type = "owe" // TODO: Integrate
            newDebt.repaymentDate = Date()
            
            newWallet.person = newPerson
            newWallet.debt = newDebt
            
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
        return amount.isEmpty || person.isEmpty
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Text(person)
                        Spacer()
                        Label("Contact", systemImage: "plus.circle")
                            .font(.title3)
                            .labelStyle(.iconOnly)
                    }
                    .onTapGesture {
                        showingContacts = true
                    }
                    .sheet(isPresented: $showingContacts) {
                        ContactView(showingContact: $showingContacts, contact: $person)
                    }
                    TextField("IDR0.00", text: $amount)
                        .keyboardType(.decimalPad)
//                        .onChange(of: amount, perform: { newValue in
//                            print(newValue)
//                            let regex = try NSRegularExpression (pattern: "^[0-9]*$")
//                        })
                        .onReceive(Just(amount)) { newAmount in
                            print(newAmount)
//                            let regex = try NSRegularExpression (pattern: "^[0-9]*$")
                            let filtered = newAmount.filter {
//                                $0.contains(Regex("^[0-9]*$"))
                                "0123456789".contains($0)
                            }
                            print (filtered)
                            if filtered != newAmount {
                                self.amount = filtered
        
                            }
                        }
                    
                    
                    HStack {
                        Text("Repayment Date")
                        Spacer()
                        DatePicker(
                            "",
                            selection: $repaymentDate,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                    }
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
            .alert(isPresented: self.$showingAlert) {
                Alert(title: Text("Contact on Pressed!"), dismissButton: .default(Text("Dismiss")))
            }
            .navigationBarTitle("New Debt",displayMode: .inline)
            .navigationBarItems(
                leading:Button("Cancel", action: {
                    self.showingSheet.toggle()
                })
            )
        }
        .background(Color(UIColor.systemGroupedBackground))
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

//struct AddDebtSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDebtSheet()
//    }
//}
