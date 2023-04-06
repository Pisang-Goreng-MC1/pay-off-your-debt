//
//  ContentView.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 03/04/23.
//

import SwiftUI


struct DebtType: Identifiable {
    let id = UUID()
    var name: String
}

struct Person: Identifiable {
    let id = UUID()
    var name: String
    var phoneNumber: String
}

struct Wallet: Identifiable {
    let id = UUID()
    var person: Person
    var totalAmount: Int
    var debt: [Debt]
    var repay: [Repay]
    
    func addDebt(debt: Debt) {
        
    }
}


struct Debt: Identifiable {
    let id = UUID()
    var person: Person
    var amount: String
    var personalNote: String
    var repaymentDate: Date
    var type: DebtType
    
    init(person: Person, amount: String, personalNote: String, repaymentDate: Date, type: DebtType) {
        self.person = person
        self.amount = amount
        self.personalNote = personalNote == "" ? "-" : personalNote
        self.repaymentDate = repaymentDate
        self.type = type
    }
}

struct Repay: Identifiable {
    let id = UUID()
    let idWallet: Int
    var date: Date
    var amount: Int
}



/*
 Sebelumnya Zady hutang ke Afif = Rp50.000
 
 Ziady hutang ke Afif = Rp20.000
 - contact: Afif
 - type: Borrow
 - amount: 20000
 - date: 6, Apr 2023
 - repaymentDate: 10, Apr 2023
 - personalNote: "pinjem yak"
 
 Ziady bayar hutang ke Afif = Rp30.000
 
 Perhitungan akhir, Ziady hutang ke Afif Rp40.000
 
 */


struct ContentView: View {
    // Initial Data
    @State var People: [Person] = []
    @State var debtTypes: [DebtType] = [
        DebtType(name: "Lent"),
        DebtType(name: "Owe")]
    @State var debts: [Debt] = [Debt]()
    @State var repays: [Repay] = []
    @State var wallets: [Wallet] = []
    
    var wallet = Wallet(person: <#T##Person#>, totalAmount: <#T##Int#>, debt: <#T##[Debt]#>, repay: <#T##[Repay]#>)
    
    // Status
    @State private var showingSheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var showingContacts: Bool = false
    
    // Data
    @State private var person: String = "Contact"
    @State private var amount: String = "0"
    @State private var personalNote: String = ""
    @State private var repaymentDate: Date = Date()
    @State private var debtType: String = "Owe"
    
    var body: some View {
        VStack {
            List {
                ForEach(debts) { debt in
                    VStack {
                        Text(debt.person.name)
                        Text(String(debt.amount))
                        Text(debt.personalNote)
                        Text(debt.repaymentDate, style: .date)
                        Text(debt.type.name)
                    }
                    
                }
            }
            .listStyle(.plain)
            
            Button("New Debt") {
                showingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showingSheet) {
                NavigationView {
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
                                    self.showingContacts = true
                                }
                                .sheet(isPresented: $showingContacts) {
                                    ContactView(showingContact: $showingContacts, contact: $person)
                                }
                                TextField("IDR0.00", text: $amount)
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
                                    self.debts.append(Debt(person: Person(name: person, phoneNumber: "085"), amount: amount, personalNote: personalNote, repaymentDate: repaymentDate, type: debtTypes[0]))
                                } label: {
                                    Text("Save")
                                        .frame(maxWidth: .infinity)
                                }
                                .listRowBackground(Color.accentColor)
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
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

